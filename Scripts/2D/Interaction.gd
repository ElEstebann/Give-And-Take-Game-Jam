extends Node2D

@export var give = true
@export var path = "AnimatedSprite2D"
var animation
var player_in_area = false
var sprite = "give"

func _ready():
	animation = get_node(path)
	if give == true:
		sprite = "take"
		animation.play(sprite)
	if give == false:
		sprite = "give"
		animation.play(sprite)
	pass


func _process(delta):
	if give == true:
		if sprite == "give":
			pass
		if player_in_area:
			if Input.is_action_just_pressed("Interact"):
				sprite = "give"
				animation.play(sprite)
	if give == false:
		if sprite == "take":
			pass
		if player_in_area:
			if Input.is_action_just_pressed("Interact"):
				sprite = "take"
				animation.play(sprite)
	pass
