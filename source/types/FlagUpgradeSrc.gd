extends Resource
class_name FlagUpgradeSrc


export(String) var display_name : String
export(String) var unique_name : String
export(String) var upgrade_name : String

export(WUBsUtils.Flags) var variable : int = WUBsUtils.Flags.ALLOW_WALL_CLIMBING
export(bool) var flag_on : bool = true
export(int, 0, 8192) var size : int = 64




func get_class() -> String:
	return C.ClassNames.FlagUpgradeSrc