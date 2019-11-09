extends Resource
class_name BossAttackPatternSrc


# percentage of propability
export(float, 0, 1) var pop : float = 0
export(PackedScene) var attack_scene : PackedScene
export(float, 0.01, 1000, 0.01) var cooldown : float = 0.01


#==== getters ====
func get_class() -> String:
	return C.ClassNames.BossAttackPatternSrc