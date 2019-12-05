extends Node
class_name StMState

onready var parent_stm = get_parent()

func enter_state() -> void:
	pass


func process_state(host : Node, delta : float) -> void:
	pass

func process_transitions(host : Node, delta : float) -> NodePath:
	for child in get_children():
		if child.get_class() == C.ClassNames.StMTransition and child.translate(host, delta):
			return child.target_state_path
			break
		
	return NodePath("")
			

func exit_state() -> void:
	pass



#==== getters ====
func get_state() -> String:
	return C.ClassNames.StMState

#==== signals ====
func __on_state_translate() -> void:
	call_deferred("_exit_state")