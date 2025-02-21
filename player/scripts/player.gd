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

func spawn_present() -> void:
	var root : Node = get_tree().root
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = presents[0]
	root.add_child(sprite)
	sprite.position = position
	sprite.scale = Vector2(present_size, present_size)
	sprite.z_index = -1
