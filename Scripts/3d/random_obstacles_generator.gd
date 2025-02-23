extends Node3D

@onready var generators = $Rows.get_children()

#budget to be affected by difficulty
#maximum of 24
@onready var budget = 3 + GameManager.difficulty -1
var gen_budget = 0

@onready var lanes = [$Lane1.position.x, 
$Lane2.position.x, 
$Lane3.position.x]


enum Distribution_Methods {EVEN,BIG,RANDOM}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Rows/RandomObstacle.lanes = lanes
	$Rows/RandomObstacle2.lanes = lanes
	$Rows/RandomObstacle3.lanes = lanes
	
	var middle_distance = generators[0].position.distance_to(generators[1].position)/2
	$Rows/RandomObstacle.middle_z = middle_distance
	$Rows/RandomObstacle2.middle_z = middle_distance
	$Rows/RandomObstacle3.middle_z = middle_distance


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generate_obstacles():
	var method = Distribution_Methods.values().pick_random()
	generators.shuffle()
	gen_budget = randi_range(budget/2,budget)
	#print("gen budget = " + str(gen_budget))
	match method:
		Distribution_Methods.RANDOM:
			distribute_randomy()
		Distribution_Methods.EVEN:
			distribute_evenly()
		Distribution_Methods.BIG:
			distribute_bigly()
func distribute_randomy():
	#print("RANDOM")
	var temp_budget = gen_budget
	for generator in generators:
		var random_budget = min(randi_range(0,generator.MAX_BUDGET),temp_budget)
		generator.generate(random_budget)
		temp_budget -= random_budget
	
func distribute_evenly():
	#print("EVEN")
	var temp_budget = gen_budget
	for generator in generators:
		var even_budget = min(temp_budget/generators.size(),temp_budget)
		if even_budget == 0 && temp_budget > 0:
			even_budget = 1
		generator.generate(even_budget)
		temp_budget -= even_budget
		

func distribute_bigly():
	#print("BIG")
	var temp_budget = gen_budget
	for generator in generators:
		generator.generate(min(generator.MAX_BUDGET,temp_budget))
		temp_budget -= min(generator.MAX_BUDGET,temp_budget)
	
	
	
