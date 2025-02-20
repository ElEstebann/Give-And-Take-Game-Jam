extends Node3D

@onready var chunks: Node3D = $Chunks

const SPEED = 10

var reset_z = 0

var highest_z = -999

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Get z bounds of chunks
	for chunk in chunks.get_children():
		if chunk.position.z < reset_z:
				reset_z = chunk.position.z
				
		if chunk.position.z > highest_z:
			highest_z = chunk.position.z


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for chunk in chunks.get_children():
		chunk.position.z += SPEED*delta
		if chunk.position.z > highest_z:
			chunk.position.z = reset_z + (chunk.position.z - highest_z)
			chunk.randomize_chunk()
