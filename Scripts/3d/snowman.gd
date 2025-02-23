extends Node3D

@onready var player = get_tree().get_nodes_in_group("3Dplayer")[0]
@onready var animation_player: AnimationPlayer = $Snowman/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.distance_to(player.global_position) < 30:
		animation_player.play("Animation")
	
	
