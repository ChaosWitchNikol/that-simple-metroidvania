extends Resource
class_name FlagUpgradeSrc



export(String) var unique_name : String
export(String) var display_name : String

export(String) var variable_name : String
export(String) var flag_name : String
export(int, 0, 8192) var size : int = 64




func get_class() -> String:
	return C.ClassNames.FlagUpgradeSrc