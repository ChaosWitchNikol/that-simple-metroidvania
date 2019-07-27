extends Node
class_name Effect

#==== variables ====
var target_variable : int
var amount : float
var variable_sign : int
var apply : int
var tick_length : float
var tick_count : int


#==== node functions ====
func _ready() -> void:
	if tick_count == 0:
		$Tick.queue_free()
		apply()
	else:
		U.setup_timer($Tick, tick_length)
		if apply == C.EFFECT_APPLY.IMMEDIATELY:
			apply()
		$Tick.start()
		




#==== functions ====
# will set all the variables and then add instance to the parent
func create(source : ResEffect) -> Effect:
	self.target_variable = source.target_variable
	self.amount = source.amount
	self.variable_sign = source.variable_sign
	self.apply = source.apply
	self.tick_length = source.tick_length
	self.tick_count = source.tick_count
	
	return self

func apply() -> void:
	print("apply > ", U.node2string(self))
	pass
func unapply() -> void:
	print("unapply > ", U.node2string(self))
	pass

func _handle_ready() -> void:
	pass

func _handle_tick() -> void:
	pass



#==== signals ====
func _on_Tick_timeout() -> void:
	if apply == C.EFFECT_APPLY.EVERY_TICK:
		call_deferred("apply")
	elif apply == C.EFFECT_APPLY.IMMEDIATELY:
		call_deferred("unapply")
	tick_count -= 1
	if tick_count == 0:
		$Tick.stop()
		queue_free()
