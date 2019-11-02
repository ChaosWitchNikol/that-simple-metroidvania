extends Resource
class_name ValueBoostSrc

export(String) var unique_name : String

export(WUBsUtils.Variables) var variable : int = WUBsUtils.Variables.MAX_HEALTH
export(float, -4096, 4096, 0.01) var add_amount : float = 0

export(float, 0, 4096, 0.01) var duration : float = 0


func get_class() -> String:
	return C.ClassNames.ValueBoostSrc

