extends Node2D

var scene = preload("res://enemies/basic_enemy.tscn")
const MAX_ENEMIES = 100 
@onready var spawn_area_upper = $"../lowerenemybound".position
@onready var spawn_area_lower = $"../upperenemybound".position
@onready var basic_enemy: CharacterBody2D = $BasicEnemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for index in min(GameManager.difficulty - 1 , MAX_ENEMIES):
		var child_added = scene.instantiate() 
		add_child(child_added)
		child_added.scale = basic_enemy.scale * randf_range(0.8,1.15)
	set_enemy_positions()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_enemy_positions():
	for enemy in get_children():
		enemy.position = Vector2(randf_range(spawn_area_lower.x,spawn_area_upper.x),randf_range(spawn_area_lower.y,spawn_area_upper.y))
