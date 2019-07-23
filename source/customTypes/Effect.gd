extends Resource
class_name CTEffect_old


# which target variable will be affected 
export(C.EFFECT_VARIABLE) var variable : int = C.EFFECT_VARIABLE.HEALTH
# how much will be added / subtracted
export(float) var value : float
# if the value should be added or subtracted
export(C.EFFECT_SIGN) var value_sign : int = C.EFFECT_SIGN.PLUS
# how long will the effect last
#	0 - when effect is instant
#	-1 - when offect is permament
export(float) var duration : float = 0





