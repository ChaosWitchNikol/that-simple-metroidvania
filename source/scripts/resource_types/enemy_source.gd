extends Resource
class_name EnemySrc

export(bool) var passive : bool = false
export(float, 0, 1000) var mass : float = 100
export(float, 0, 1000, 10) var movement_speed : float = 400
export(float, 0.01, 5) var attack_delay : float = 0.01
export(float) var attack_range : float = 1 setget ,get_attack_range

func get_attack_range() -> float:
	print("getting attack tange")
	return attack_range * C.TILE_SIZEF