extends CharacterBody2D


@export var SPEED : float = 300.0
@export var sneak_speed : float = 85
@export var slow_time : float = 1
const JUMP_VELOCITY = -400.0

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle")

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
	if vel.length() <= 0.1:
		vel = Vector2.ZERO
		var current_animation : String = anim.animation as String
		var test : StringName = StringName("idle")
		
		anim.play("idle")
			
	elif is_sneaking:
		speed = sneak_speed
		anim.play("sneak")
	else:
		anim.play("walk") 
	vel = vel.normalized() * speed * delta
	velocity = vel
