extends Node
class_name StMTransition

export(NodePath) var target_state_path : NodePath


func translate(host : Node, delta : float) -> bool:
	# implement condition here
	return false


#==== getters ====
func get_class() -> String:
	return C.ClassNames.StMTransition