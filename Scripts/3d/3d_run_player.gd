extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10
const GRAVITY_MULT = 2.5

@onready var animation_player: AnimationPlayer = $Sketchfab_Scene/AnimationPlayer2

@export var invulnerable = false

func _enter_tree():
	add_to_group("3Dplayer")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_MULT

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	velocity.z = 0

	move_and_slide()


func _on_hitbox_area_entered(area: Area3D) -> void:
	if(not invulnerable):
		on_damaged()
	
func on_damaged() -> void:
	#print("Damaged!")
	animation_player.play("3d_player_damaged")
	invulnerable = true
	$InvulnerabilityTimer.start()


func _on_invulnerability_timer_timeout() -> void:
	#animation_player.stop(false)
	animation_player.play("normal")
	invulnerable = false
	#print("timer done")
