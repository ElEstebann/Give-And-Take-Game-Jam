class_name TaskManager extends Node

var give_counter = 0
var take_counter = 0
var no_task = "res://Scenes/3D/RunGame.tscn"

@onready var TaskLog: CanvasLayer = UiManager.get_node('TaskLog')
@onready var TaskTitle: RichTextLabel = UiManager.get_node('TaskLog').get_node('Task Info')
@onready var Completion: RichTextLabel = UiManager.get_node('TaskLog').get_node('Completion')

@export_group("Task Settings")
@export var task_name: String = "Give and Take Gifts"
@export var task_description: String = "Taken" + "\n" + "   " + str(give_counter) + "/5" + "\n" + "Given" + "\n" + "   " + str(take_counter) + "/5"
@export var task_completion: String = "Exit To Next House"

enum TaskStatus{
	not2D,
	inprogress,
	finished,
}

@export var task_status: TaskStatus = TaskStatus.not2D

@export_group("Score Total")
@export var score_amount: int

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		$"Pause Menu".visible = true
		get_tree().paused = true
