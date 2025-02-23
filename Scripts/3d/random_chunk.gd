extends Node3D
@onready var left_side: Node3D = $LeftSide
@onready var right_side: Node3D = $RightSide
@onready var obstacles: Node3D = $Obstacles

@export var obstacles_on_start = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if obstacles_on_start:
		obstacles.generate_obstacles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func randomize_chunk() -> void:
	left_side.randomize_estate()
	right_side.randomize_estate()
	obstacles.generate_obstacles()
