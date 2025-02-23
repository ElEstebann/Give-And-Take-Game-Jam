extends Control

func _on_play_pressed() -> void:
	GameManager.game_starting()
	get_tree().change_scene_to_file("res://Scenes/3D/RunGame.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
 
