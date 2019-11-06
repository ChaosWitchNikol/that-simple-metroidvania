extends KinematicBody2D
class_name Hero

export(float, 0, 39.2) var gravity : float = C.GRAVITY_VALUE setget , _get_gravity
export(float, 0, 400) var mass : float = 100 setget , _get_mass
export(float, 0, 1000) var movement_speed : float = 500 setget , _get_movement_speed
export(float, 0, 2000) var jump_force : float = 15 setget , _get_jump_force
export(int, 0, 10) var allowed_jumps : int = 1 setget , _get_allowed_jumps
export(float, 0, 1) var jump_delay : float = 0.1 setget , _get_jump_delay
export(bool) var allow_wall_climbing : bool = false setget , _get_allow_wall_climbing


var linear_velocity := Vector2()
var jumps_count : int = 0
var jump_timeout : float = 0

var health : float = 10
var max_health : float = 10



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
func collectable_collected(item : Resource) -> void:
	if not item:
		return
	
	match(item.get_class()):
		C.ClassNames.ValueUpgradeSrc:
			print("value upgrade collected")
			$ValueUpgradesHandler.add_upgrade(item)
		C.ClassNames.ValueBoostSrc:
			print("value boost collected")
			$ValueBoostsHandler.add_boost(item)
		C.ClassNames.FlagUpgradeSrc:
			print("flag upgrade collected")
			$FlagUpgradesHandler.add_upgrade(item)
		



#==== getters ====
func get_camera_position() -> Vector2:
	return $Cam.global_position


func get_camera() -> Camera2D:
	return $Cam as Camera2D


#==== variables getters ====
func _get_gravity() -> float: 
	return gravity

func _get_mass() -> float:
	return mass

func _get_movement_speed() -> float:
	return movement_speed + $ValueUpgradesHandler.get_movement_speed() + $ValueBoostsHandler.get_movement_speed()

func _get_jump_force() -> float:
	return jump_force + $ValueUpgradesHandler.get_jump_force() + $ValueBoostsHandler.get_jump_force()

func _get_allowed_jumps() -> int:
	return allowed_jumps

func _get_jump_delay() -> float:
	return jump_delay

func _get_allow_wall_climbing() -> bool:
	return allow_wall_climbing || $FlagUpgradesHandler.get_allow_wall_climbing() || $FlagBoostHandler.get_allow_wall_climbing()

#==== node getters ====
func get_class() -> String:
	return C.ClassNames.Hero


#==== setters ====
func set_facing(value : int) -> void:
	if value == facing:
		return
	
	facing = value
	$AttackTarget.position.x = abs($AttackTarget.position.x) * facing
	$Sprite.flip_h = facing == C.FACING.LEFT