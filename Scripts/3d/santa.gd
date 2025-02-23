extends Node3D
@onready var player = get_tree().get_nodes_in_group("3Dplayer")[0]
@onready var animation_player: AnimationPlayer = $Sketchfab_Scene/AnimationPlayer

@onready var SPEED = player.SPEED/2
var minimum_distance = 0.75


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("hello_wave")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player == null:
		print("null player")
		return
	
	if global_position.distance_to(player.global_position) > 30:
		return

	
	if abs(player.position.x - position.x) < minimum_distance:
		animation_player.play("hello_wave")
		return
		
	if position.x > player.position.x:
		animation_player.play("turn_right")
	else:
		animation_player.play("turn_left")
		
	position.x = move_toward(position.x,player.position.x,SPEED*delta)
		
