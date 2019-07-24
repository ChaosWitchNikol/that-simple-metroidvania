extends Resource
class_name ResEffect

# which variable will be affected
export(C.EFFECT_TARGET) var target : int = C.EFFECT_TARGET.HEALTH
# how much
export(float,0 , 8192) var amount : float = 0
# either add or subtract
export(C.EFFECT_SIGN) var target_sign : int = C.EFFECT_SIGN.PLUS
# how long will the effect stay active
#	0 - effect is instant
#	-1 - effect is permanent
export(float, -1, 1024, 0.01) var duration : float = 0 setget _set_duration


#==== setters ====
func _set_duration(value: float) -> void:
	if value < 0.0:
		value = -1
	duration = value