extends Node
class_name StM

signal state_changed

var host : Node

export(NodePath) var initial_state_path : NodePath setget _set_initial_state_path
var _state : StMState


#==== node functions ====
func _ready() -> void:
	host = get_parent()


func _physics_process(delta: float) -> void:
	if _state:
		_state.process_state(self, delta)
		


#==== setters ====
func _set_initial_state_path(state: NodePath) -> void:
	initial_state_path = state
	if U.in_editor():
		_state = get_node(state)



#==== getters ====
func get_class() -> String:
	return C.ClassNames.StM


#==== signals ====
func __on_change_state(new_state : NodePath) -> void:
	pass