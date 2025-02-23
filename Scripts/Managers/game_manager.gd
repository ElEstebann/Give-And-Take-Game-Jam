class_name gaymanager extends Node


const MAX_HEALTH = 4
var difficulty = 20
var score = 0
var health = MAX_HEALTH

var PlayerHealth = "."

@onready var grinch_chiptune: AudioStreamPlayer = $GrinchChiptune
@onready var grinch_theme: AudioStreamPlayer = $GrinchTheme

@onready var grinch_chiptune_volume = $GrinchChiptune.volume_db
@onready var grinch_theme_volume = $GrinchTheme.volume_db
@onready var damage_sfx: AudioStreamPlayer = $sfx/damaged
@onready var laugh: AudioStreamPlayer = $sfx/Laugh
@onready var yay: AudioStreamPlayer = $sfx/Yay
@onready var sfx: Node = $sfx
@onready var jump: AudioStreamPlayer = $sfx/Jump
@onready var christmas: AudioStreamPlayer = $sfx/Christmas
@onready var ding: AudioStreamPlayer = $sfx/Ding
@onready var merrychristmas: AudioStreamPlayer = $sfx/Merrychristmas


enum Music { CHIPTUNE,NORMAL}
var current_song = Music.NORMAL

static var instance = null

func _on_ready() -> void:
	if instance == null:
		instance = self
	play_music()
	difficulty_update()
	
static func swap_music():
	print("SWAPPING SONGS")
	match instance.current_song:
		Music.CHIPTUNE:
			instance.grinch_theme.volume_db = instance.grinch_theme_volume
			instance.grinch_chiptune.volume_db = -80
			instance.current_song = Music.NORMAL
		Music.NORMAL:
			instance.grinch_theme.volume_db = -80
			instance.grinch_chiptune.volume_db = instance.grinch_chiptune_volume
			instance.current_song = Music.CHIPTUNE

static func play_music():
	instance.grinch_theme.play()
	instance.grinch_chiptune.play()
	instance.grinch_theme.volume_db = instance.grinch_theme_volume
	instance.grinch_chiptune.volume_db = -80
	
static func play_song(song):
	match song:
		Music.CHIPTUNE:
			instance.grinch_theme.volume_db = -80
			instance.grinch_chiptune.volume_db = instance.grinch_chiptune_volume
			
		Music.NORMAL:
			instance.grinch_theme.volume_db = instance.grinch_theme_volume
			instance.grinch_chiptune.volume_db = -80
	instance.current_song = song


	

static func damage() -> bool:
	instance.health -= 1
	print("HEALTH: " + str(instance.health))
	instance.damage_sfx.play()
	if(instance.health <= 0):
		game_over()
		return true
	
	return false

static func game_over():
	instance.difficulty = 1
	difficulty_update()
	instance.get_tree().change_scene_to_file("res://Scenes/Managers/game_over.tscn")
	
static func difficulty_up():
	instance.difficulty += 1
	difficulty_update()
	
static func difficulty_update():
	instance.grinch_chiptune.pitch_scale = 1 + (float(instance.difficulty - 1) / 50.0)
	instance.grinch_theme.pitch_scale = 1 + (float(instance.difficulty - 1) / 50.0)
	for sound in instance.sfx.get_children():
		sound.pitch_scale =  1 + (float(instance.difficulty - 1) / 50.0)
	Engine.time_scale = 1 + (float(instance.difficulty - 1) / 50.0)
	
static func play_laugh():
	instance.laugh.play()

static func play_yay():
	instance.yay.play()
	
static func play_jump():
	instance.jump.play()
	
static func play_christmas():
	instance.christmas.play()

static func play_ding():
	instance.ding.play()

static func score_up():
	instance.score += 1

static func game_starting():
	#instance.merrychristmas.play()
	instance.score = 0
	instance.health = MAX_HEALTH

static func get_score():
	return instance.score
