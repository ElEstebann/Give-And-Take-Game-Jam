extends Node2D

@export_group("Random Generation")
@export var object: Array[NodePath] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(object.pick_random())
	var path: NodePath = object.pick_random()
	var obj = get_node(path)
	obj.visible = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
