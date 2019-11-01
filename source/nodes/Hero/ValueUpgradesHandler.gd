extends HandlerNode

var upgrades :  Dictionary = {}
var upgrades_indexes : Dictionary = {}


#==== functions ====
func add_upgrade(upgrade : ValueUpgradeSrc) -> void:
	# create new upgrade dictionary
	# for now active is true by default
	var new_upgrade : Dictionary = { 
		"name": upgrade.display_name,
		"amount": upgrade.add_amount,
		"variable": upgrade.variable,
		"active": true,
	}
	var new_upgrade_key : String = upgrade.unique_name
	
	var next_index := _update_upgrade_index(upgrade.unique_name)
	if next_index > 0:
		new_upgrade_key += "@" + str(next_index)
		
	print("added upgrade", new_upgrade_key, new_upgrade)
	
	upgrades[new_upgrade_key] = new_upgrade


func _update_upgrade_index(upgrade_unique_name: String) -> int:
	var current_index : int = upgrades_indexes.get(upgrade_unique_name, -1)
	var next_index : int = current_index + 1
	upgrades_indexes[upgrade_unique_name] = next_index
	return next_index



#==== getters ====
func _get_active_upgrades() -> Dictionary:
	var active_upgrades := {}
	for upgrade_key in upgrades.keys():
		if upgrades[upgrade_key].active:
			active_upgrades[upgrade_key] = upgrades[upgrade_key]
	return active_upgrades


func _get_active_upgrades_variable_type(upgrade_variable_type : int) -> Dictionary:
	var active_upgrades : Dictionary = _get_active_upgrades()
	
	var type_upgrades : Dictionary = {}
	for upgrade_key in active_upgrades.keys():
		if active_upgrades[upgrade_key].variable == upgrade_variable_type:
			type_upgrades[upgrade_key] = active_upgrades[upgrade_key]
	
	return type_upgrades


func _get_active_upgrades_variable_type_amount(upgrade_variable_type : int) -> float:
	var amount : float = 0.0
	
	for value in _get_active_upgrades_variable_type(upgrade_variable_type).values():
		amount += value.amount
	
	return amount


func _get_active_upgrades_variable_type_amount_i(upgrade_variable_type : int) -> int:
	return int(_get_active_upgrades_variable_type_amount(upgrade_variable_type))


#== by variable name ==
func get_max_health() -> float:
	return _get_active_upgrades_variable_type_amount(HeroUtils.Variables.MAX_HEALTH)

func get_jump_force() -> float:
	return _get_active_upgrades_variable_type_amount(HeroUtils.Variables.JUMP_FORCE)

func get_movement_speed() -> float:
	return _get_active_upgrades_variable_type_amount(HeroUtils.Variables.MOVEMENT_SPEED)