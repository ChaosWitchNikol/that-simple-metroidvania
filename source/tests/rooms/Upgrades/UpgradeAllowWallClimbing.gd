extends _TestRoom



func _process(delta: float) -> void:
	$CanvasLayer/Allow.text = str($Hero.allow_wall_climbing)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		$CanvasLayer/Jump.modulate = Color("#e500ec")
	if event.is_action_released("ui_select"):
		$CanvasLayer/Jump.modulate = Color("#ffffff")
	
	if event.is_action_pressed("ui_left"):
		$CanvasLayer/Left.modulate = Color("#e500ec")
	if event.is_action_released("ui_left"):
		$CanvasLayer/Left.modulate = Color("#ffffff")
	
	
	if event.is_action_pressed("ui_right"):
		$CanvasLayer/Right.modulate = Color("#e500ec")
	if event.is_action_released("ui_right"):
		$CanvasLayer/Right.modulate = Color("#ffffff")
