extends Node


var upgrades : Dictionary = {}
var upgrades_indexes : Dictionary = {}


#==== functions ====
func add_upgrade(upgrade : FlagUpgradeSrc) -> void:
	# create new upgrade dictionary
	# for now active is true by default
	var new_upgrade : Dictionary = {
		"name" : upgrade.display_name,
		"variable": upgrade.variable,
		"on": upgrade.flag_on,
		"active": true,
	}
	
	var new_upgrade_key : String = upgrade.unique_name
	
	var new_index := _update_upgrade_index(upgrade.unique_name)
	if new_index > 0:
		new_upgrade_key += "@" + str(new_index)
	
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

func _is_upgrade_flag_type_on(flag_name : int) -> bool:
	var flag_on : bool = false
	
	for upgrade in upgrades.values():
		if upgrade.variable == flag_name and upgrade.active and upgrade.on:
			flag_on = true
			break
			
	return flag_on


#== by variable name ==
func get_allow_wall_climbing() -> bool:
	return _is_upgrade_flag_type_on(WUBsUtils.Flags.ALLOW_WALL_CLIMBING)