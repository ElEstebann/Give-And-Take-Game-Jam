extends Control

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://player/scenes/test_main.tscn")
	get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Managers/main_menu.tscn")
	get_tree().paused = false
