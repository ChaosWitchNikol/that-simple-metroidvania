extends Node
class_name BossUtils



class BossPhasesComparer:
	static func compare(a: BossPhaseSrc, b: BossPhaseSrc) -> bool:
		return a.min_health_percent > b.min_health_percent

static func sort_phases(phases: Array) -> Array:
	phases.sort_custom(BossPhasesComparer, "compare")
	return phases
	
