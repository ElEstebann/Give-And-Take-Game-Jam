extends Node3D
@onready var random_house: Node3D = $RandomHouse
@onready var trees: Node3D = $Trees


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func randomize_estate() -> void:
	random_house.randomize_home()
	trees.randomize_trees()
