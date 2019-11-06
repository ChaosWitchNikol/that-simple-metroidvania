extends Resource
class_name FlagBoostSrc

export(String) var unique_name : String

export(WUBsUtils.Flags) var variable : int = WUBsUtils.Flags.ALLOW_WALL_CLIMBING
export(bool) var flag_on : bool = true

export(float, 0, 4096, 0.01) var duration : float = 0



func get_class() -> String:
	return C.ClassNames.FlagBoostSrc
