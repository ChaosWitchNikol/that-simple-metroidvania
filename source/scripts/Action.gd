tool
extends Node2D
class_name Action


export(Array, Resource) var effects : Array setget _set_effects






#==== setters ====
func _set_effects(array : Array) -> void:
	var size_diff : int = array.size() - effects.size()
	if size_diff > 0:
		array[array.size() - 1] = ResEffect.new()
	effects = array
		