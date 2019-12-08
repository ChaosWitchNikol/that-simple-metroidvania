tool
extends StM
class_name BossPhase

#==== exports ====
export(float, 0, 1) var active_at_health_percent : float = 0

#==== node functions ====
func _enter_tree() -> void:
	if not get_scene_instance_load_placeholder():
		set_scene_instance_load_placeholder(true)

#==== getters ====
func get_class() -> String:
	return C.ClassNames.BossPhase
