extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var attack_cooldown: float = 3
var movement_target_position: Vector2 = Vector2(60.0,180.0)

@onready var navigation_agent: NavigationAgent2D = $CollisionShape2D/NavigationAgent2D

var start_speed : float
func _ready():
	start_speed = movement_speed
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	if waited == false: return
	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	
	navigation_agent.target_position = movement_target

func _get_player() -> player:
	
	var p : player = player.INSTANCE
	
	return p
var waited : bool = false
func _physics_process(_delta):
	var p : player = _get_player()
	if p == null: 
		return
	if waited == false:
		waited = true
		return
	set_movement_target(p.position)
	
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if "player" not in body.name.to_lower(): return
	print(body.name, " TOUCHED ENEMY 3")
	movement_speed = 0
	if body is player:
		var p : player = body
		p.TakeDamage()
	
	var tree = get_tree()
	if tree != null:
		await tree.create_timer(attack_cooldown).timeout
	movement_speed = start_speed
	
