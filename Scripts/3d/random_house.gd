extends Node3D




@onready var home_list = [$Homes/house_type022,
 $Homes/house_type032,
 $Homes/house_type042,
 $Homes/house_type052,
 $Homes/house_type062,
 $Homes/house_type072,
 $Homes/house_type082,
 $Homes/house_type092,
 $Homes/house_type102,
 $Homes/house_type112,
 $Homes/house_type122,
 $Homes/house_type132,
 $Homes/house_type142,
 $Homes/house_type152,
 $Homes/house_type162,
 $Homes/house_type172,
 $Homes/house_type182,
 $Homes/house_type192,
 $Homes/house_type202,
 $Homes/house_type212,
 $Homes/house_type012]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_home()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func randomize_home() -> void:
	for item in home_list:
		item.visible = false
	home_list[randi_range(0,home_list.size()-1)].visible = true
	print_debug("House Randomized")
