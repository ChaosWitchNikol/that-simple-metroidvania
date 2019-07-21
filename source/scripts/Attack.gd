extends Area2D
class_name Attack


#==== variables ====
var effects : Array
var movement_speed : float
var max_targets : int
var direciton : Vector2


#==== node functions ====
func _ready() -> void:
	set_physics_process(false)
func _physics_process(delta: float) -> void:
	if movement_speed <= 0.0:
		return


#==== custom functions ====
func do_fire(start_position: Vector2, direction : Vector2) -> void:
	self.global_position = start_position
	self.direction = direction
	set_physics_process(true)