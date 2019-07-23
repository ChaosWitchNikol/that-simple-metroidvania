extends Resource
class_name ResEffect_old

# which target variable will be affected 
export(C.EFFECT_VARIABLE) var variable : int = C.EFFECT_VARIABLE.HEALTH
# how much will be added / subtracted
export(float) var value : float = 0
# if the value should be added or subtracted
export(C.EFFECT_SIGN) var value_sign : int =C.EFFECT_SIGN.PLUS
# how long will the effect last
#	0 - when effect is instant
#	-1 - when offect is permament
export(float, -1, 1024, 0.01) var duration : float = 0 setget _set_duration


#==== setters ====
func _set_duration(value : float) -> void:
	if value < 0.01:
		value = 0
	elif value < 0.0:
		value = -1
	duration = value

