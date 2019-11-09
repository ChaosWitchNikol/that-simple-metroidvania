extends Node

var boosts : Array = []


##==== node functions ====
func _process(delta: float) -> void:
	if boosts.empty():
		return
	
	var indexes_to_remove : Array = []
	
	# update time to live for eaach boost
	for index in range(0, boosts.size()):
		boosts[index].ttl -= delta
		if boosts[index].ttl <= 0:
			indexes_to_remove.append(index)
	
	# remove non active boosts
	for index in indexes_to_remove:
		boosts.remove(index)



#==== functions ====
func add_boost(boost : ValueBoostSrc) -> void:
	var new_boost : Dictionary = {
		"variable": boost.variable,
		"amount": boost.add_amount,
		"ttl": boost.duration
	}
	boosts.append(new_boost)
	


#==== getters ====
func _get_boosts_variable_type_amount(variable_type : int) -> float:
	var amount : float = 0
	
	for boost in boosts:
		if boost.variable == variable_type:
			amount += boost.amount
	
	return amount


#== by variable name
func get_max_health() -> float:
	return _get_boosts_variable_type_amount(WUBsUtils.Variables.MAX_HEALTH)


func get_jump_force() -> float:
	return _get_boosts_variable_type_amount(WUBsUtils.Variables.JUMP_FORCE)


func get_movement_speed() -> float:
	return _get_boosts_variable_type_amount(WUBsUtils.Variables.MOVEMENT_SPEED)