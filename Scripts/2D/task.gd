class_name Task extends TaskManager


func _ready() -> void:
	print("ready")
	
	if get_tree().current_scene.name == "RunGame":
		TaskLog.visible = false
		task_status = TaskStatus.not2D
	if get_tree().current_scene.name != "RunGame":
		TaskLog.visible = true
		task_status = TaskStatus.inprogress
		TaskTitle.text = task_name
		Completion.text = task_description
	pass # Replace with function body.

func task_complete() -> void:
	if task_status == TaskStatus.finished:
		Completion.text = task_completion
