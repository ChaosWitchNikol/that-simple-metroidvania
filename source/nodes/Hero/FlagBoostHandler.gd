extends Node



var boosts : Array = []


#==== node functions ====
func _process(delta: float) -> void:
	if boosts.empty():
		return
	
	var indexes_to_remove : Array = []
	
	for index in range(0, boosts.size()):
		boosts[index].ttl -= delta
		if boosts[index].ttl <= 0:
			indexes_to_remove.append(index)
	
	
	for index in indexes_to_remove:
		boosts.remove(index)



#==== functions ====
func add_boost(boost : FlagBoostSrc) -> void:
	var new_boost : Dictionary = {
		"variable" : boost.variable,
		"on" : boost.flag_on,
		"ttl" : boost.duration
	}
	
	boosts.append(new_boost)


#==== getters ====
func _is_boost_flag_type_on(flag_name : int) -> bool:
	var flag_on : bool = false
	
	for boost in boosts:
		if boost.variable == flag_name:
			flag_on = true
			break
	
	return flag_on



func get_allow_wall_climbing() -> bool:
	return _is_boost_flag_type_on(WUBsUtils.Flags.ALLOW_WALL_CLIMBING)