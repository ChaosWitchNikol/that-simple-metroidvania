extends HandlerNode
class_name UniqueHandlerNode


export(String) var unique_name : String = ""
export(bool) var is_current : bool = false



#==== node functions ====
func _ready() -> void:
	if is_current:
		make_current()
	else:
		clear_current()


#==== functions =====
func make_current() -> void:
	is_current = true
	for child in P.get_children():
		if child.get_class() == "UniqueHandlerNode" and child.unique_name == unique_name and child != self:
			child.clear_current()


func clear_current() -> void:
	is_current = false



#==== getters ====
func get_class() -> String:
	return "UniqueHandlerNode"