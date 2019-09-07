extends HandlerNode
class_name AttackHandler

#==== exports ====
export(PackedScene) var attack_scene : PackedScene
export(bool) var is_emitter : bool = true
export(bool) var is_reciever : bool = true


#==== functions ====
func emit_attack(target : Node2D) -> void:
	if not is_emitter:
		return
	
	var attack := attack_scene.instance()
	attack.assemly(P)
	if attack.get_class() == "AttackBullet":
		attack.fire_bullet(target.global_position, P.global_position)
		get_tree().get_root().add_child(attack)
	elif attack.get_class() == "Attack":
		get_tree().get_root().add_child(attack)
		attack.execute_on(target)



func recieve_attack(effects : Array) -> void:
	print(effects)