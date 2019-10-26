extends _TestRoom




func _physics_process(delta: float) -> void:
	$CanvasLayer/HeroSpeed.text = str($Hero.movement_speed)
