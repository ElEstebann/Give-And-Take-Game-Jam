extends Node2D

@export var give = true
var player_in_area = false
var sprite = "give"

func _ready():
	if give == true:
		sprite = "take"
		$AnimatedSprite2D.play(sprite)
	if give == false:
		sprite = "give"
		$AnimatedSprite2D.play(sprite)
	pass


func _process(delta):
	if give == true:
		if sprite == "give":
			pass
		if player_in_area:
			if Input.is_action_just_pressed("Interact"):
				sprite = "give"
				$AnimatedSprite2D.play(sprite)
	if give == false:
		if sprite == "take":
			pass
		if player_in_area:
			if Input.is_action_just_pressed("Interact"):
				sprite = "take"
				$AnimatedSprite2D.play(sprite)
	pass
