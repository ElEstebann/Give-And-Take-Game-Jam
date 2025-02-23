extends Control

func _on_retry_pressed() -> void:
	GameManager.game_starting()
	get_tree().change_scene_to_file("res://Scenes/3D/RunGame.tscn")

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Managers/main_menu.tscn")


func _on_label_2_ready() -> void:
	$HBoxContainer/Label2.text = str(GameManager.get_score())
