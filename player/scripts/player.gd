extends CharacterBody2D
class_name player

@export var SPEED : float = 300.0
@export var sneak_speed : float = 85
@export var slow_time : float = 1

@export var presents : Array[Texture2D]
@export var present_size : float = 5
const JUMP_VELOCITY = -400.0

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
static var INSTANCE : player

func _ready() -> void:
	anim.play("idle")
	INSTANCE = self
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		spawn_present()

func _physics_process(delta: float) -> void:
	
	movement(delta)
	move_and_collide(velocity)

func movement(delta : float) -> void:
	if IS_ANIMATING: return
	var vel : Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		vel.x -= 1
		anim.flip_h = true
	if Input.is_action_pressed("down"):
		vel.y += 1
	if Input.is_action_pressed("up"):
		vel.y -= 1
	if Input.is_action_pressed("right"):
		vel.x += 1
		anim.flip_h = false
	var is_sneaking : bool = Input.is_action_pressed("sneak")
	var speed : float = SPEED
	if is_sneaking:
		speed = sneak_speed
		anim.play("sneak")
	elif vel.length() <= 0.1:
		vel = Vector2.ZERO
		anim.play("idle")
	else:
		anim.play("walk") 
	vel = vel.normalized() * speed * delta
	velocity = vel

var IS_ANIMATING : bool = false
@onready var present_pos = $PresentPos
func spawn_present() -> void:
	if IS_ANIMATING: return
	var pos : Vector2 = global_position
	var offset = present_pos.position
	if anim.flip_h:
		offset.x *= -1.3
	pos += offset
	level_manager.SpawnPresentAt(pos)
	anim.animation_looped.connect(_idle_after)
	anim.play("reverse_snatch")
	IS_ANIMATING = true
	return

func _idle_after():
	anim.play("idle")
	IS_ANIMATING = false
	var to_remove = []
	for sig in anim.animation_looped.get_connections():
		to_remove.append(sig)
	for sig in to_remove:
		anim.animation_looped.disconnect(sig["callable"])
@export var flicker_time : float = 0.3
@export var flicker_counts : int = 5
var IS_TAKING_DAMAGE : bool = false
func TakeDamage():
	if IS_TAKING_DAMAGE: return
	IS_TAKING_DAMAGE = true
	var start_mod : Color = modulate
	for _i in range(flicker_counts):
		modulate = Color.RED
		await get_tree().create_timer(flicker_time).timeout
		modulate = start_mod
		await get_tree().create_timer(flicker_time).timeout
	IS_TAKING_DAMAGE = false
