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

func _process(_delta: float) -> void:
	if task_status == TaskStatus.inprogress:
		if give_counter == 5 && take_counter == 5:
			task_status = TaskStatus.finished
			task_complete()
			pass
	pass

func task_complete() -> void:
	if task_status == TaskStatus.finished:
		Completion.text = task_completion
		give_counter = 0
		take_counter = 0
	pass

func update_task() -> void:
	task_description = "Taken" + str(give_counter) + "/5" + "\n" + "Given" + "\n" + str(take_counter) + "/5"
