extends Node
class_name BossPhaseList


#==== variables ====
export(NodePath) var initial_phase_path : NodePath
var phase : BossPhase


#==== node functions ====
func _ready() -> void:
	instance_phase_from_path(initial_phase_path)
	pass


#==== functions ====
func instance_phase_from_path(phase_path : NodePath) -> void:
	var new_phase_placeholder := get_node(phase_path)
	if new_phase_placeholder and new_phase_placeholder is InstancePlaceholder:
		var new_phase := (new_phase_placeholder as InstancePlaceholder).create_instance()
		if new_phase.get_class() == C.ClassNames.BossPhase:
			if phase:
				var old_phase : BossPhase = phase
				remove_child(old_phase)
			phase = new_phase



#==== gettters ====
func get_class() -> String:
	return C.ClassNames.BossPhaseList