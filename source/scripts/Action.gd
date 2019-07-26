extends Node
class_name Action


#==== preloads ====
var effect_scene : PackedScene = preload("res://scenes/Effect.tscn")


#==== exports ====
export(Array, Resource) var effects : Array setget _set_effects


#==== functions ====
func apply_effects(target: Node) -> void:
	for effect in effects:
		if target.has_method("add_effect"):
			target.add_effect(effect_scene.instance().create(effect))
		else:
			target.add_child(effect_scene.instance().create(effect))


#==== setters ====
func _set_effects(array : Array) -> void:
	var size_diff : int = array.size() - effects.size()
	if size_diff > 0:
		array[array.size() - 1] = ResEffect.new()
	effects = array
