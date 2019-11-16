extends _TestRoom

#==== node functions ====
func _ready() -> void:
	$CanvasLayer/Name.text = name
	$CanvasLayer/BossControl.visible = false


func _process(delta: float) -> void:
	$CanvasLayer/BossControl/CurrentPhase.text = $Boss.current_phase_node.name
	$CanvasLayer/BossControl/HP.text = str($Boss.health)



#==== functions ====
func _set_boss_taget(hero : Hero) -> void:
	$Boss.set_target(hero)
	

func _decrease_boss_health(amount : float) -> void:
	$Boss.health -= amount




func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is Hero:
		call_deferred("_set_boss_target", body as Hero)
		$CanvasLayer/BossControl.visible = true

func _on_BossHealthTimer_timeout() -> void:
	call_deferred("_decrease_boss_health", 1)