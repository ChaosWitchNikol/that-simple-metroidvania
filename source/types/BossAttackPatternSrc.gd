extends Resource
class_name BossAttackPatternSrc


export(PackedScene) var attack_scene : PackedScene
export(float, 0.01, 1000, 0.01) var cooldown : float = 0.01
export(int, 1, 1024) var magnitude : int = 1



#==== getters ====
func get_class() -> String:
	return C.ClassNames.BossAttackPatternSrc