extends Node
class_name StMState


func enter_state() -> void:
	pass


func process_state(host : Node, delta : float) -> void:
	pass


func exit_state() -> void:
	pass



func _process_transitions(host : Node, delta : float) -> NodePath:
	for child in get_children():
		if child.get_class() == C.ClassNames.StMTransition and child.translate(host, delta):
			return child.target_state_path
			break
	return NodePath("")



#==== getters ====
func get_class() -> String:
	return C.ClassNames.StMState
