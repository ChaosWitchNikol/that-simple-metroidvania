extends _TestRoom

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		print("do attack")
		$Direct/Sprite/AttackHandler.emit_attack($Target)
		$Bullet/Sprite/AttackHandler.emit_attack($Target)