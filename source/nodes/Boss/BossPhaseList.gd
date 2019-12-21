extends Node
class_name BossPhaseList


#==== variables ====
export(NodePath) var host_path : NodePath
export(NodePath) var initial_phase_path : NodePath
var phase : BossPhase


#==== node functions ====
func _ready() -> void:
	select_current_phase_from_path(initial_phase_path)
	pass


#==== functions ====
func select_current_phase_from_path(phase_path : NodePath) -> void:
	var new_phase : BossPhase = get_node(phase_path)
	if new_phase.get_class() == C.ClassNames.BossPhase:
		var old_phase : BossPhase = phase
		phase = new_phase


#==== gettters ====
func get_class() -> String:
	return C.ClassNames.BossPhaseList