extends Control

@export var rotate_speed : float = 1
@export var size_amplitude : float = 1
@export var size_frequency : float = 1

@onready var start_size : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_size = scale
	rotation_degrees += randf_range(0, 90)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += (delta * rotate_speed)
	var sin = (cos(Time.get_ticks_msec() * size_frequency) * size_amplitude)
	scale = start_size + Vector2(sin, sin)
	#print("Cos: ", sin, " delta: ", delta)


func _on_crosshair_entered(area: Area2D) -> void:
	print("Hit : " , area.name)


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("Hit (2): " , area.name)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "present" in body.name.to_lower():
		level_manager.instance.OnPresentPlaced.emit()
		#print("Hit (3): " , body.name)
		self.queue_free()
