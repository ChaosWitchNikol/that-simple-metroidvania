extends StM
class_name BossPhase

#==== exports ====
export(float, 0, 1) var active_at_health_percent : float = 0


#==== getters ====
func get_class() -> String:
	return C.ClassNames.BossPhase
