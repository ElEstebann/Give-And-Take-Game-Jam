extends Node

@onready var PlayerHealth = $"."
@onready var ass: CanvasLayer = PlayerHealth.get_node('Health')
@onready var dick: RichTextLabel = PlayerHealth.get_node('Health').get_node('HP')

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	dick.text = "Health: " + str(GameManager.instance.health)
