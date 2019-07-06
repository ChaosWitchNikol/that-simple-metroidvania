extends EnemyBase
class_name EnemyFly


var forward_vector : Vector2 = Vector2()


#	flying enemy does not need gravity :D
func process_gravity(delta : float, do_process : bool = true) -> void:
	pass

func process_movement(delta : float) -> void:
	pass
