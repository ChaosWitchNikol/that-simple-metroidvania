extends Node
class_name Effect

#==== variables ====
var target_variable : int
var amount : float
var variable_sign : int
var duration : float
var tick_time : float
export(C.FACING, "left", "right") var aloha : int

#==== node functions ====
func _ready() -> void:
	# setup timers
	U.setup_timer($Duration, duration)
	U.setup_timer($Tick, tick_time)



#==== functions ====
# will set all the variables and then add instance to the parent
func create(source : ResEffect) -> Effect:
	self.target_variable = source.target_variable
	self.amount = source.amount
	self.variable_sign = source.variable_sign
	self.duration = source.duration
	self.tick_time = source.tick_time
	
	return self

func _handle_ready() -> void:
	pass

func _handle_tick() -> void:
	pass

func _handle_duration() -> void:
	pass
