extends Resource
class_name ValueUpgradeSrc


export(String) var unique_name : String
export(String) var display_name : String

export(HeroUtils.Variables) var variable : int = HeroUtils.Variables.MAX_HEALTH
export(float, -4096, 4096, 0.01) var add_amount : float = 0
export(int, 0, 8192) var size : int = 64



func get_class() -> String:
	return C.ClassNames.ValueUpgradeSrc