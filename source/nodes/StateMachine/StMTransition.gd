extends Node
class_name StMTransition

#==== exports ====
export(NodePath) var target_state_path : NodePath



#==== functions ====
func translate(host : Node, delta : float) -> bool:
	# implement condition here
	return false



#==== getters ====
func get_class() -> String:
	return C.ClassNames.StMTransition