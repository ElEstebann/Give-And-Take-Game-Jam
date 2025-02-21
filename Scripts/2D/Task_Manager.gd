class_name TaskManager extends Node

@onready var TaskLog: CanvasLayer = UiManager.get_node('TaskLog')
@onready var TaskTitle: RichTextLabel = UiManager.get_node('TaskLog').get_node('Task Info')
@onready var Completion: RichTextLabel = UiManager.get_node('TaskLog').get_node('Completion')

@export_group("Task Settings")
@export var task_name: String
@export var task_description: String
@export var task_completion: String

enum TaskStatus{
	not2D,
	inprogress,
	finished,
}

@export var task_status: TaskStatus = TaskStatus.not2D

@export_group("Score Total")
@export var score_amount: int
