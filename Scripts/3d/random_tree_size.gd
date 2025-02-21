extends Node3D

@onready var tree_list = [$"tree-snow-b2",
 $tree2,
 $"tree-snow-b3",
 $tree3,
 $"tree-snow-b4",
 $tree4,
 $"tree-snow-b5",
 $tree5]

@onready var max_size = $tree5.scale.y
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_trees()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func randomize_trees() ->void:
	for item in tree_list:
		var rand_mod = randf()*4
		item.scale.x = max_size - rand_mod
		item.scale.y = max_size - rand_mod
		item.scale.z = max_size - rand_mod
	
	#print_debug("trees randomized")
		
	
