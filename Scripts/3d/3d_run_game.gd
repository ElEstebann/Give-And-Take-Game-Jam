extends Node3D

var street_names = [
	"Main", "Oak", "Pine", "Maple", "Cedar", "Elm", "Birch", "Willow", "Spruce", "Sycamore",
	"Chestnut", "Hickory", "Walnut", "Aspen", "Juniper", "Magnolia", "Redwood", "Poplar", "Alder", "Beech",
	"Fir", "Sequoia", "Cypress", "Dogwood", "Hemlock", "Laurel", "Cottonwood", "Holly", "Rowan", "Palm",
	"Ash", "Olive", "Mulberry", "Linden", "Gingko", "Yew", "Bamboo", "Tamarack", "Acacia", "Myrtle",
	"Hawthorn", "Elder", "Bay", "Sandalwood", "Ironwood", "Hazel", "Buckeye", "Sumac", "Mimosa", "Sassafras",
	"Banyan", "Baobab", "Persimmon", "Tupelo", "Locust", "Mahogany", "Guava", "Fig", "Mango", "Coconut",
	"Lemon", "Orange", "Peach", "Cherry", "Plum", "Pear", "Apple", "Grape", "Blackberry", "Raspberry",
	"Blueberry", "Strawberry", "Cranberry", "Currant", "Gooseberry", "Pomegranate", "Quince", "Avocado", "Kiwi", "Papaya",
	"Date", "Eucalyptus", "Aloe", "Agave", "Yucca", "Junco", "Clover", "Thyme", "Sage", "Basil",
	"Rosemary", "Lavender", "Marjoram", "Anise", "Dill", "Fennel", "Chicory", "Tansy", "Daisy", "Violet", "Esteban", "Matthew", "Dane"
]


var street_suffixes = [
	"Street", "Avenue", "Boulevard", "Drive", "Road", 
	"Lane", "Way", "Court", "Place", "Terrace"
]

var time_left = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"CameraHandle/Street Name".text = "GO TO\n" + get_street_name().to_upper()
	GameManager.play_song(GameManager.Music.NORMAL)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_left -= delta
	update_timer()
	if(time_left < 0):
		end_game()
	
	
	
func get_street_name() -> String:
	return str(randi_range(111,999)) + " " + street_names.pick_random() + " " + street_suffixes.pick_random()

func update_timer():
	$CameraHandle/Panel/Label.text = str(ceil(time_left))
	
func end_game():
	%"3DRunPlayer".position.y = -999
	$WinScreen/Estate/AnimationPlayer.play("win")
	$CameraHandle/Panel.visible = false






func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#GameManager.swap_music()
	GameManager.score_up()
	get_tree().change_scene_to_file("res://player/scenes/test_main.tscn")
	
