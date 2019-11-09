extends _TestRoom



func _process(delta: float) -> void:
	$CanvasLayer/Allow.text = str($Hero.allow_wall_climbing)
	
	var boosts_text : String = ""
	for boost in $Hero/FlagBoostHandler.boosts:
		var status : String = "OFF"
		if boost.on:
			status = "ON"
		boosts_text += "boost [ %s ] [ %s ]; ttl [ %f ]\n" % [WUBsUtils.flag2str(boost.variable), status, boost.ttl]
	
	$CanvasLayer/Boosts.text = boosts_text
	


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