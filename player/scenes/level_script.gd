extends Node2D

@onready var nav_region : NavigationRegion2D = $NavigationRegion2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""
	var polygon = nav_region.navigation_polygon
	var verts = polygon.get_vertices()
	for vert in verts:
		print("Started with vert: ", vert)
	for corner in [Vector2(-1, -1), Vector2(-1, 1), Vector2(1, -1), Vector2(1, 1)]:
		var vert = present01.global_position + corner * 4
		verts.append(vert)
		print("Added vert: ", vert)
	
	polygon.set_vertices(verts)
	nav_region.bake_navigation_polygon(true)
	"""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
