tool
extends Resource
class_name BossPhaseSrc



export(float, 0, 1) var min_health_percent : float = 1
export(Array, Resource) var attack_patterns : Array = [] setget _set_attack_patterns
export(Script) var phase_script : Script



#==== getters ====
func get_class() -> String:
	return C.ClassNames.BossPhaseSrc

func get_magnitude_sum() -> int:
	if attack_patterns.empty():
		return 1
	
	var magnitude : int = 0
	
	for item in attack_patterns:
		magnitude += item.magnitude
	
	return magnitude



#==== setters ====
func _set_attack_patterns(array : Array) -> void:
	if U.in_editor() and not array.empty():
		for i in range(0, array.size()):
			if not array[i] or array[i].get_class() != C.ClassNames.BossAttackPatternSrc:
				array[i] = BossAttackPatternSrc.new()
	
	attack_patterns = array