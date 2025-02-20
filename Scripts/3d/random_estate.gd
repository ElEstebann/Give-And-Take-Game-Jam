extends Node3D
@onready var random_house: Node3D = $RandomHouse
@onready var trees: Node3D = $Trees

@export var is_flipped = false

@onready var flippables = [$Decorations/nutcracker2,
 $Decorations/reindeer2,
 $"Decorations/gingerbread-woman2",
 $"Decorations/gingerbread-man2",
 $Decorations/snowman2,
 $Decorations/sled2,
$Decorations/reindeer3, 
$"Decorations/gingerbread-woman3", 
$"Decorations/gingerbread-man3"
]

@onready var decorations: Node3D = $Decorations


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	decorate()
	if is_flipped:
		for flippable in flippables:
			flippable.rotate(Vector3(0,1,0),deg_to_rad(90))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func randomize_estate() -> void:
	random_house.randomize_home()
	trees.randomize_trees()
	decorate()
	
func decorate() -> void:
	for decoration in decorations.get_children():
		if randf() < 0.75:
			decoration.visible = false
		else:
			decoration.visible = true
