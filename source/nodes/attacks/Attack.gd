tool
extends Area2D
class_name Attack


#==== exports ====
export(Array, Resource) var effects : Array setget _set_effects
#==== variables ====
var _origin : Node2D

var origin_effects : Array
var target_effects : Array

#==== node functions ====
func _ready() -> void:
	if U.in_editor():
		if not effects or effects.size() == 0:
			effects.append(EffectSrc.new())
		return



#==== functions ====
func assemble(origin : Node2D) -> void:
	_origin = origin
	
	# set up if is affecting self and target
	for effect in effects:
		if (effect as EffectSrc).target_self:
			if not origin_effects:
				origin_effects = []
			origin_effects.append(effect)
		else:
			if not target_effects:
				target_effects = []
			target_effects.append(effect)


func execute_on(target : Node2D) -> void:
	AttackUtils.apply_efects_to_node2D(target, target_effects)
	AttackUtils.apply_efects_to_node2D(_origin, origin_effects)



#==== setters ====
func _set_effects(array : Array) -> void:
	for index in range(0, array.size()):
		if not array[index] or not array[index] is EffectSrc:
			array[index] = EffectSrc.new()
	effects = array



#==== getters ====
func get_class() -> String:
	return "Attack"