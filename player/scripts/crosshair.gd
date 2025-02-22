extends Control

@export var rotate_speed : float = 1
@export var size_amplitude : float = 1
@export var size_frequency : float = 1

@onready var start_size : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_size = scale
	print("Set size to ", start_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += (delta * rotate_speed)
	var sin = (cos(Time.get_ticks_msec() * size_frequency) * size_amplitude)
	scale = start_size + Vector2(sin, sin)
	#print("Cos: ", sin, " delta: ", delta)
