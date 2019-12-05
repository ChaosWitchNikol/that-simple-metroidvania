extends Node
class_name StMTransition

onready var parent_state : StMState = get_parent()
export(NodePath) var target_state_path : NodePath

