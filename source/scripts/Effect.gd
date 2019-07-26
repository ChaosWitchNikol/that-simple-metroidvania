extends Node
class_name Effect

#==== variables ====
var target_variable : int
var amount : float
var variable_sign : int
var duration : float
var tick_time : float


#==== node functions ====
func _ready() -> void:
	# setup timers
	_setup_timer($Duration, duration)
	_setup_timer($Tick, tick_time)


#==== functions ====
func _setup_timer(timer : Timer, wait_time : float) -> void:
	if wait_time == -1:
		timer.queue_free()
	else:
		timer.wait_time = wait_time
		timer.start()

# will set all the variables and then add instance to the parent
func create(source : ResEffect) -> Effect:
	self.target_variable = source.target_variable
	self.amount = source.amount
	self.variable_sign = source.variable_sign
	self.duration = source.duration
	self.tick_time = source.tick_time
	
	return self
