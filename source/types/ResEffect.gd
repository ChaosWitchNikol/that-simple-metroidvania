tool
extends Resource
class_name ResEffect

#==== variables ====
# which variable will be affected
export(C.EFFECT_TARGET) var target_variable : int = C.EFFECT_TARGET.HEALTH
# how much
export(float,0 , 8192) var amount : float = 0
# either add or subtract
export(C.EFFECT_SIGN) var variable_sign : int = C.EFFECT_SIGN.PLUS
# when the effect should be applied
export(C.EFFECT_APPLY) var apply : int = C.EFFECT_APPLY.EVERY_TICK
# how often will targeted variable be change by anount
export(float, 0.01, 4096) var tick_length : float = 0.01
# how many times it is possible to apply tick
#	0 - effect will be permanent
export(int, 0, 4096, 1) var tick_count : int = 1
