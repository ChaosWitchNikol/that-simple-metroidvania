extends Node
class_name StM

#==== signals ====
signal state_changed

#==== exports ====
export(NodePath) var host_path : NodePath
export(NodePath) var initial_state_path : NodePath setget _set_initial_state_path

#==== variables ==== 
var host : Node
var state : StMState



#==== node functions ====
func _ready() -> void:
	host = get_node(host_path)
	set_new_state_from_path(initial_state_path)


func _physics_process(delta: float) -> void:
	if state:
		state.process_state(host, delta)
		var new_state_path : NodePath = state._process_transitions(host, delta)
		if not new_state_path.is_empty():
			call_deferred("set_new_state_from_path", new_state_path)



#==== setters ====
func _set_initial_state_path(state: NodePath) -> void:
	initial_state_path = state


func _set_state(new_state: StMState) -> void:
	state = new_state
	emit_signal("state_changed", state)


func set_new_state_from_path(new_state_path : NodePath) -> void:
	var new_state := get_node(new_state_path)
	
	if new_state.get_class() != C.ClassNames.StMState:
		return
	
	_set_state(new_state)



#==== getters ====
func get_class() -> String:
	return C.ClassNames.StM
