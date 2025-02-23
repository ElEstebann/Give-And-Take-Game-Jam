extends Node3D

enum choices {TREE,CAR,SANTA,SNOWMAN,SPIKE}
@onready var obstacles_1 = $Trees.get_children() + $Snowmen.get_children() + $Spikes.get_children()
@onready var obstacles_2 = $Cars.get_children()
@onready var obstacles_3 = $Santas.get_children()

var obstacles_1_used = 0
var obstacles_2_used = 0
var obstacles_3_used = 0

var middle_z = 5


var lanes = [-1,0,1]

const MAX_BUDGET = 8

enum Generation_Methods {BIG,SMALL,EVEN, RANDOM}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_all()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func hide_all() -> void:
	for obstacle in obstacles_1:
		obstacle.position.y = 999
	for obstacle in obstacles_2:
		obstacle.position.y = 999
	for obstacle in obstacles_3:
		obstacle.position.y = 999
	reset_usage()

func show_obstacle(type : choices, location : Vector3):
	#obstacles[type].position = location
	pass
	
func generate(budget):
	#print("generating with budget: " + str(budget))
	budget = min(MAX_BUDGET,budget)
	
	if budget <= 0:
		hide_all()
		return
	
	
	var method = Generation_Methods.values().pick_random()
	match method:
		Generation_Methods.BIG:
			generate_big(budget)
		Generation_Methods.EVEN:
			generate_even(budget)
		Generation_Methods.SMALL:
			generate_small(budget)
		Generation_Methods.RANDOM:
			generate_random (budget)
		
			
			
func generate_big(budget):
	#print("GEN BIG W/ " + str(budget))
	var lanes = [0,0,0]
	var middle = 0
	
	var obstacles = [0,0,0,0]
	for index in obstacles.size():
		if budget <= 0:
			break
		
		obstacles[index] = min(budget, 3)
		budget -= min(budget, 3)
	
	obstacles.shuffle()
	lanes = [obstacles[0],obstacles[1],obstacles[2]]
	middle = obstacles[3]
	
	
	display_obstacles(lanes,middle)
	
func generate_small(budget):
	var lanes = [0,0,0]
	var middle = 0
	for index in lanes.size():
		lanes[index] = min(budget,1)
		budget -= min(budget,1)
		
	middle = min(budget,3)

	
	display_obstacles(lanes,middle)
	
func generate_even(budget):
	var lanes = [budget/3,budget/3,budget/3]
	var middle = budget - (budget/3)*3
	
	#print("Evenly generated: " + str(lanes) + " " + str(middle)) 
	display_obstacles(lanes,middle)

func generate_random(budget):
	var lanes = [0,0,0]
	var middle = 0
	
	for index in lanes.size():
		var random_obstacle = min(randi_range(0,3),budget)
		lanes[index] = random_obstacle
		budget -= random_obstacle
	
	middle = min(randi_range(0,3),budget)
	
	display_obstacles(lanes,middle)
	
func display_obstacles(lanes,middle,shuffle = true):
	var sanitize = true
	if sanitize:
		#sanitize input
		var santa_count = 0
		var car_count = 0
		for index in lanes.size():
			if lanes[index] == 3:
				santa_count += 1
			if lanes[index] == 3 &&santa_count >= 2:
				lanes[index] = middle
				middle = 3
			if lanes[index] == 3 &&santa_count >= 3:
				lanes = [3,0,0]
				break
				
			if lanes[index] == 2:
				car_count += 1
			if lanes[index] == 2 && car_count >=3:
				lanes[index] = 1
		if middle == 2:
			middle = 1
		if santa_count >= 1:
			lanes = [3,0,0]
	if shuffle:
		lanes.shuffle()
				
		
	#print("Displayed: " + str(lanes) + ", " + str(middle))
	
	hide_all()
	obstacles_1.shuffle()
	display_lane(0,lanes[0])
	display_lane(1,lanes[1])
	display_lane(2,lanes[2])
	display_middle(middle)
	
	
	

func display_lane(lane,val) -> void:
	if val <= 0:
		return
		
	var obstacle = get_obstacle(val)
	obstacle.position.y = 0
	obstacle.position.x = lanes[lane]

func display_middle(val) -> void:
	if val <= 0:
		return
	var obstacle = get_obstacle(val)
	obstacle.position.y = 0
	obstacle.position.x = randf_range(lanes[0],lanes[lanes.size()-1])
	obstacle.position.z = middle_z

func get_obstacle(value) -> Node3D:
	var obstacle = null
	match value:
		1:
			obstacle = obstacles_1[obstacles_1_used]
			obstacles_1_used += 1
		2:
			obstacle =  obstacles_2[obstacles_2_used]
			obstacles_2_used += 1
		3:
			obstacle = obstacles_3[obstacles_3_used]
			obstacles_3_used += 1
	return obstacle

func reset_usage() -> void:
	obstacles_1_used = 0
	obstacles_2_used = 0
	obstacles_3_used = 0
