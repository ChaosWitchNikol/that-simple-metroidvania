tool
extends KinematicBody2D
class_name Boss


export(Array, Resource) var phases : Array = [] setget _set_phases





#==== setters ====
func _set_phases(array : Array) -> void:
	if U.in_editor() and not array.empty():
		for i in range(0, array.size()):
			if not array[i]:
				array[i] = BossPhaseSrc.new()
	phases = array
	





