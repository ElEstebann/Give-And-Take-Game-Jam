extends Node3D
@onready var left_side: Node3D = $LeftSide
@onready var right_side: Node3D = $RightSide


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func randomize_chunk() -> void:
	left_side.randomize_estate()
	right_side.randomize_estate()
