tool
extends Area2D
class_name Teleport

const EF_INVERT : int = 1
const EF_TRIM : int = 2

signal teleport_entered
signal teleport_exited
signal is_being_exited

#==== target teleport ====
export(NodePath) var target_teleport_path : NodePath
#==== parent zone ====
export(NodePath) var parent_zone_path : NodePath

#==== transition ====
export(float, -1, 1024, 0.01) var transport_duration : float = 1 setget _set_transport_duration
export(float, -1, 16, 0.01) var takeover_duration : float = 0.3 setget _set_takeover_duration

#==== interaction ====
export(bool) var force_interaction : bool = false

#==== exit location ====
export(int, FLAGS, "Invert", "Trim") var exit_x : int
export(int, FLAGS, "Invert", "Trim") var exit_y : int


#==== variables ====
var is_exit : bool = false
var interacting_hero : Hero




#==== node functions ====
func _ready() -> void:
	if U.in_editor():
		return
	
	if not target_teleport_path:
		queue_free()
		return
	
	_override_children()




#==== cutom functions ====
func transport_hero(hero : Hero) -> void:
	hero.take_controll()
	$Cam.global_position = hero.get_camera().get_camera_screen_center()
		
	var target_teleport : Teleport = get_node(target_teleport_path)
	target_teleport.make_exit()
	
	# setup
	$Cam.make_current()
	$Cam/BlackOver.self_modulate = Color("00ffffff")
	$Cam/BlackOver.visible = true
	
	# enter the teleport
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, global_position, takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.interpolate_property($Cam/BlackOver, "self_modulate", $Cam/BlackOver.self_modulate, Color("ffffffff"), takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	
	# emit signal after the screen is blacked out
	emit_signal("teleport_entered", self)
	
	var exit_position : Vector2 = get_exit_position(target_teleport, hero)
	
	hero.jump_to_position(exit_position)
	
	# move to target location
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, target_teleport.global_position, transport_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.interpolate_property(hero, "global_position", hero.global_position, exit_position, (transport_duration / 5) * 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	
	
	# move hero to target location
#	hero.jump_to_position(exit_position)
	
	emit_signal("teleport_exited", self)
	target_teleport.emit_signal("is_being_exited")
	
	hero.get_camera().make_current()
	var camera_position : Vector2 = hero.get_camera().get_camera_screen_center()
	$Cam.make_current()
	
	# exit the the teleport	$Cam.
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, camera_position, takeover_duration * 0.75, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.interpolate_property($Cam/BlackOver, "self_modulate", $Cam/BlackOver.self_modulate, Color("00ffffff"), takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	
	
	
	# clear
	$Cam/BlackOver.visible = false
	
	hero.give_controll()


func make_exit() -> void:
	is_exit = true


func _override_children() -> void:
	# override for normal collision
	if has_node("Collision"):
		var col : CollisionShape2D = get_node("Collision")
		$TeleportCollision.shape = col.shape
		col.queue_free()
		


#==== getters ====
func get_exit_position(target_teleport : Teleport, hero : Hero) -> Vector2:
	var exit_position : Vector2 = target_teleport.global_position
	if target_teleport.has_node("Exit"):
		exit_position = target_teleport.get_node("Exit").global_position
	
	var position_offset : Vector2 = (hero.global_position - global_position)
	# check for possible invertion of XY
	if exit_x & EF_INVERT:
		position_offset.x *= -1
	if exit_y & EF_INVERT:
		position_offset.y *= -1
	# check for possible trim of XY
	if exit_x & EF_TRIM:
		position_offset.x = 0
	if exit_y & EF_TRIM:
		position_offset.y = 0
	
	return exit_position + position_offset


func get_zone_placeholder() -> InstancePlaceholder:
	return get_node(parent_zone_path) as InstancePlaceholder


func get_target_teleport_zone_placeholder() -> InstancePlaceholder:
	return (get_node(target_teleport_path) as Teleport).get_zone_placeholder()



#==== setters ====
func _set_transport_duration(value : float) -> void:
	if value < 0.01:
		value = -1
	transport_duration = value


func _set_takeover_duration(value : float) -> void:
	if value < 0.01:
		value = -1
	takeover_duration = value






#==== signals ====
func _on_Teleport_body_entered(body: PhysicsBody2D) -> void:
	if is_exit:
		return
	if body is Hero:
		if force_interaction:
			interacting_hero = body as Hero
		else:
			call_deferred("transport_hero", body as Hero)


func _on_Teleport_body_exited(body: PhysicsBody2D) -> void:
	if not is_exit:
		return
	if force_interaction and body == interacting_hero:
		interacting_hero = null
	# reset the exit
	is_exit = false
