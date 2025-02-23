extends Node2D
class_name level_manager
@onready var nav_region : NavigationRegion2D = $NavigationRegion2D
@onready var present_prefab = preload("res://enemies/present_obstacle.tscn")
static var instance : level_manager = null
@onready var crosshair_prefab = preload("res://player/scenes/crosshair.tscn")
@onready var label : RichTextLabel = $GUI/RichTextLabel
@onready var presesnts_label : RichTextLabel = $GUI/PresentsLabel
@onready var gui : Control = $GUI
@export var screen_padding : float = 10
@export var invalid_color : Color = Color.DARK_RED
@export var valid_color : Color = Color.WEB_GREEN
signal OnPresentPlaced

"""
TODO !!

> Levels have lists of tasks
  >> Place X presents at Y locations
> Kidnap children

"""

var size
func _ready() -> void:
	size = get_viewport_rect().size
	
	instance = self
	OnPresentPlaced.connect(_on_present_spawn)
	_init_level()	

#difficulty scale for the level, 0 to 100

static var difficulty : int = 10

var _presents_left : int
func _init_level():
	# NUM presents to drop off is first digit of difficulty 
	# PLUS random(0, 3)
	# so if difficulty is 30, NUM presents is 3 + rand(0, 3)
	
	#HARDCODE FOR TESTING
	var num_presents = 3
	_set_presents_label(num_presents)
	for i in range(num_presents):
		SpawnRandomPresent()
	_presents_left = num_presents
	


func _on_present_spawn():
	_presents_left -= 1
	if _presents_left < 0: _presents_left = 0
	_set_presents_label(_presents_left)
	label.text = "Hooray!"
func SpawnRandomPresent():
	var x : float = randf_range(screen_padding, size.x - screen_padding)
	var y : float = randf_range(screen_padding, size.y - screen_padding)
	_spawn_crosshair_at(Vector2(x, y))
	
func _spawn_crosshair_at(pos : Vector2) -> void:
	
	var crosshair : Control = crosshair_prefab.instantiate()
	gui.add_child(crosshair)
	crosshair.position = pos

static func Bake_Navmesh():
	if instance == null: return
	instance.nav_region.bake_navigation_polygon()
static func SpawnPresentAt(pos : Vector2) -> void:
	if instance == null: return
	var present : Node = instance.present_prefab.instantiate()
	instance.nav_region.add_child(present)
	present.position = pos
	

func _set_presents_label(num_left : int) -> void:
	var text : String = ""
	if num_left <= 0:
		var c = valid_color.to_html(false)
		text = "[color=#%s]CONGRATULATIONS!![/color]" % c
		get_tree().change_scene_to_file("res://Scenes/3D/RunGame.tscn")
	else:
		var c = invalid_color.to_html(false)
		text = "Place [color=#%s]%d more[/color] presents" % [c, num_left]
	presesnts_label.parse_bbcode(text)
