extends Node
class_name BossUtils



class BossPhasesComparer:
	static func compare_desc(a: BossPhaseSrc, b: BossPhaseSrc) -> bool:
		return a.start_at_health_percent > b.start_at_health_percent
	
	static func compare_asc(a: BossPhaseSrc, b: BossPhaseSrc) -> bool:
		return a.start_at_health_percent < b.start_at_health_percent 

const SORT_DIRECTIONS : Array = ["desc", "asc"]

static func sort_phases(phases: Array, direction: String = "desc") -> Array:
	if not direction in SORT_DIRECTIONS:
		direction = "desc"
	phases.sort_custom(BossPhasesComparer, "compare_%s" % direction)
	return phases
	
