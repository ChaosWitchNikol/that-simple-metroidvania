extends _TestRoom

func _physics_process(delta: float) -> void:
	$CanvasLayer/HeroSpeed.text = str($Hero.movement_speed)
	
	
	
	var boosts_text = ""
	for boost in $Hero/ValueBoostsHandler.boosts:
		boosts_text += "boost [ %s ]; amount [ %d ]; ttl [ %f ] \n" % [HeroUtils.variable2string(boost.variable), boost.amount, boost.ttl]
	$CanvasLayer/Boosts.text = boosts_text
