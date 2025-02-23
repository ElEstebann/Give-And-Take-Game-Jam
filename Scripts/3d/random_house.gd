extends Node3D



@onready var homes = $Homes.get_children()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_home()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func randomize_home() -> void:
	for item in homes:
		item.visible = false
		
	homes[randi_range(0,homes.size()-1)].visible = true
	#print_debug("House Randomized")
