extends Node


var max_health = 4
var score = 0
var health = max_health

@onready var grinch_chiptune: AudioStreamPlayer = $GrinchChiptune
@onready var grinch_theme: AudioStreamPlayer = $GrinchTheme

enum Music { CHIPTUNE,NORMAL}
var current_song = Music.NORMAL

static var instance = null

func _on_ready() -> void:
	play_music()
	if instance == null:
		instance = self
	
func swap_music():
	print("SWAPPING SONGS")
	match current_song:
		Music.CHIPTUNE:
			grinch_theme.volume_db = 0
			grinch_chiptune.volume_db = -80
			current_song = Music.NORMAL
		Music.NORMAL:
			grinch_theme.volume_db = -80
			grinch_chiptune.volume_db = 0
			current_song = Music.CHIPTUNE

func play_music():
	grinch_theme.play()
	grinch_chiptune.play()
	grinch_theme.volume_db = 0
	grinch_chiptune.volume_db = -80
	
func play_song(song):
	match song:
		Music.CHIPTUNE:
			grinch_theme.volume_db = 0
			grinch_chiptune.volume_db = -80
			current_song = Music.NORMAL
		Music.NORMAL:
			grinch_theme.volume_db = -80
			grinch_chiptune.volume_db = 0
			current_song = Music.CHIPTUNE



func damage():
	health -= 1
	if(health <= 0):
		game_over()

func game_over():
	health = max_health
	
