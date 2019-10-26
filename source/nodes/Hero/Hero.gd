extends KinematicBody2D
class_name Hero

export(float, 0, 39.2) var gravity : float = C.GRAVITY_VALUE
export(float, 0, 400) var mass : float = 100
export(float, 0, 1000) var movement_speed : float = 500
export(float, 0, 2000) var jump_force : float = 15
export(int, 0, 10) var allowed_jumps : int = 1
export(float, 0, 1) var jump_delay : float = 0.1
export(bool) var allow_wall_climbing : bool = false


var linear_velocity := Vector2()
var jumps_count : int = 0
var jump_timeout : float = 0

var health : float = 10



var facing : int = C.FACING.RIGHT

#==== node functions ====
func _enter_tree() -> void:
	U.add_node_to_groups(self, [C.GROUP_HERO])



#==== functions ====
#== teleport ==
func take_controll() -> void:
	$Cam.clear_current()
	$WarpController.make_current()

func give_controll() -> void:
	$Cam.make_current()
	$InputController.make_current()

func jump_to_position(new_position : Vector2) -> void:
	global_position = new_position


#== input ==
func fire() -> void:
	$AttackHandler.emit_attack($AttackTarget)


#== collectables ==
func collectable_collected(type : int, item : Resource) -> void:
	print(type, U.object2string(item))
	pass



#==== getters ====
func get_camera_position() -> Vector2:
	return $Cam.global_position


func get_camera() -> Camera2D:
	return $Cam as Camera2D


#==== setters ====
func set_facing(value : int) -> void:
	if value == facing:
		return
	
	facing = value
	$AttackTarget.position.x = abs($AttackTarget.position.x) * facing
	$Sprite.flip_h = facing == C.FACING.LEFT