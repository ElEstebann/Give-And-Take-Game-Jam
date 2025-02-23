extends Node


const MAX_HEALTH = 4
var difficulty = 1
var score = 0
var health = MAX_HEALTH

@onready var grinch_chiptune: AudioStreamPlayer = $GrinchChiptune
@onready var grinch_theme: AudioStreamPlayer = $GrinchTheme

enum Music { CHIPTUNE,NORMAL}
var current_song = Music.NORMAL

static var instance = null

func _on_ready() -> void:
	if instance == null:
		instance = self
	play_music()
	
static func swap_music():
	print("SWAPPING SONGS")
	match instance.current_song:
		Music.CHIPTUNE:
			instance.grinch_theme.volume_db = 0
			instance.grinch_chiptune.volume_db = -80
			instance.current_song = Music.NORMAL
		Music.NORMAL:
			instance.grinch_theme.volume_db = -80
			instance.grinch_chiptune.volume_db = 0
			instance.current_song = Music.CHIPTUNE

static func play_music():
	instance.grinch_theme.play()
	instance.grinch_chiptune.play()
	instance.grinch_theme.volume_db = 0
	instance.grinch_chiptune.volume_db = -80
	
static func play_song(song):
	match song:
		Music.CHIPTUNE:
			instance.grinch_theme.volume_db = 0
			instance.grinch_chiptune.volume_db = -80
			instance.current_song = Music.NORMAL
		Music.NORMAL:
			instance.grinch_theme.volume_db = -80
			instance.grinch_chiptune.volume_db = 0
			instance.current_song = Music.CHIPTUNE


	

static func damage():
	instance.health -= 1
	print("HEALTH: " + str(instance.health))
	if(instance.health <= 0):
		game_over()

static func game_over():
	instance.health = MAX_HEALTH
	instance.get_tree().change_scene_to_file("res://Scenes/Managers/game_over.tscn")
	
static func difficulty_up():
	instance.difficulty += 1
	
static func score_up():
	instance.score += 1
