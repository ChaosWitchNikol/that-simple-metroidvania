extends HandlerNode


export(PackedScene) var attack_scene : PackedScene


#==== functions ====
func emit_attack(target : Node2D) -> void:
	var attack := attack_scene.instance()
	if attack is AttackBullet:
		get_tree().get_root().add_child(attack)
		attack.fire_bullet(target.global_position, P.global_position)
	elif attack is Attack:
		get_tree().get_root().add_child(attack)
		(attack as Attack).apply_effects_to_target(target)