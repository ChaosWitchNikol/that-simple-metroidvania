extends Resource
class_name ResEffect

#==== variables ====
# which variable will be affected
export(C.EFFECT_TARGET) var target_variable : int = C.EFFECT_TARGET.HEALTH
# how much
export(float,0 , 8192) var amount : float = 0
# either add or subtract
export(C.EFFECT_SIGN) var variable_sign : int = C.EFFECT_SIGN.PLUS
# how long will the effect stay active
#	-1 - effect is permanent
export(float, -1, 1024, 0.01) var duration : float = 0.01 setget _set_duration
# how often will the targeted variable be changed by amount
#	-1  - and duration = -1 the variable is affected on ready
#		- and duration >= 0.01 change variable at the begging and remove when duration ends
#	>= 0.01 - and duration = -1 or duration >= 0.01 - vartiable is affected every tick
export(float, -1, 32, 0.01) var tick_time : float = 0.01 setget _set_tick_time


#==== setters ====
func _set_duration(value: float) -> void:
	if value < 0.01:
		value = -1
	duration = value

func _set_tick_time(value: float) -> void:
	if value < 0.01:
		value = -1
	tick_time = value