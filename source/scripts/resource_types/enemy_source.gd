extends Resource
class_name EnemySource

export(bool) var passive : bool = false
export(float, 0, 1000) var mass : float = 100
export(float, 0, 1000, 10) var movement_speed : float = 400
export(float, 0, 100, .5) var view_distance : float = 8 setget ,get_view_distance
export(float, 0.01, 5) var attack_delay : float = 0.01
export(float) var attack_range : float = 1 setget ,get_attack_range

func get_view_distance() -> float:
	print("geeting view")
	return view_distance * C.TILE_SIZEF

func get_attack_range() -> float:
	print("getting attack tange")
	return attack_range * C.TILE_SIZEF