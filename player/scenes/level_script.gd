extends Node2D
class_name level_manager
@onready var nav_region : NavigationRegion2D = $NavigationRegion2D
@onready var present_prefab = preload("res://enemies/present_obstacle.tscn")
static var instance : level_manager = null
@onready var crosshair : Control = $GUI/Crosshair
@onready var label : Label = $GUI/Label

@export var screen_padding : float = 10


"""
TODO !!

> Levels have lists of tasks
  >> Place X presents at Y locations
> Kidnap children

"""


func _ready() -> void:
	var size = get_viewport_rect().size
	var x : float = randf_range(screen_padding, size.x - screen_padding)
	var y : float = randf_range(screen_padding, size.y - screen_padding)
	crosshair.position = Vector2(x, y)
	print("Moved crosshair to ", crosshair.position)
	instance = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

static func SpawnPresentAt(pos : Vector2) -> void:
	if instance == null: return
	var present : Node = instance.present_prefab.instantiate()
	instance.nav_region.add_child(present)
	present.position = pos
	instance.nav_region.bake_navigation_polygon()
	var text = "Distance to target: %d" % instance.crosshair.position.distance_to(pos)
	instance.label.text = text
	pass
