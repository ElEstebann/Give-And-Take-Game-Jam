extends Node2D

@export var grow_speed : float = 1

var start_scale : Vector2
func _ready() -> void:
	start_scale = scale
	scale = Vector2.ZERO

var baked : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scale.length_squared() >= start_scale.length_squared():
		if baked == false:
			baked = true
			level_manager.Bake_Navmesh()
		return
	var d = delta * grow_speed
	scale += Vector2(d, d)
