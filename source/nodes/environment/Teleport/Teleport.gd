tool
extends Area2D
class_name Teleport

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
export(bool) var force_interaction : bool = false setget _set_force_interaction

#==== exit location ====
export(bool) var center_to_exit_x : bool = false
export(bool) var center_to_exit_y : bool = false

#==== variables ====
var is_exit : bool = false




#==== node functions ====
func _ready() -> void:
	# set wall collision shape same as collision
	$Wall/Collision.shape = $TeleportCollision.shape
	
	if U.in_editor():
		return
	
	if not target_teleport_path:
		queue_free()
		return
	
	_override_children()




#==== cutom functions ====
func transport_hero(hero : Hero) -> void:
	hero.take_controll()
	$Cam.global_position = hero.get_camera_position()
		
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
	
	# move to target location
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, target_teleport.global_position, transport_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	$CamTweens.interpolate_property(hero, "global_position", hero.global_position, target_teleport.get_exit_position(), transport_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	
	# move hero to target location
	hero.jump_to_position(target_teleport.get_exit_position())
	
	emit_signal("teleport_exited", self)
	target_teleport.emit_signal("is_being_exited")
	
	# exit the the teleport	$Cam.
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, target_teleport.get_exit_position(), takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.interpolate_property($Cam/BlackOver, "self_modulate", $Cam/BlackOver.self_modulate, Color("00ffffff"), takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
#	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	
	# clear
	$Cam/BlackOver.visible = false
	
	hero.give_controll()

func make_exit() -> void:
	is_exit = true


func _override_children() -> void:
	# overrride for wall collision shape
	if has_node("WallCollision"):
		var collision : CollisionShape2D= get_node("WallCollision")
		$Wall/Collision.shape = collision.shape
		collision.queue_free()
	# override for normal collision
	if has_node("Collision"):
		var col : CollisionShape2D = get_node("Collision")
		$TeleportCollision.shape = col.shape
		col.queue_free()
	# override for interact collision
	if has_node("InteractCollision"):
		var col : CollisionShape2D = get_node("InteractCollision")
		$Interact/Collision.shape = col.shape
		col.queue_free()
	# override for exit
	if has_node("Exit"):
		var exit : Node2D = get_node("Exit")
		$ExitPosition.position = exit.position
		exit.queue_free()
		

#==== getters ====
func get_exit_position() -> Vector2:
	return $ExitPosition.global_position


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


func _set_force_interaction(value : bool) -> void:
	force_interaction = value
	$Interact.visible = value
	$Interact/Collision.disabled = !value



#==== signals ====
func _on_Teleport_body_entered(body: PhysicsBody2D) -> void:
	if is_exit:
		return
	if body is Hero:
		call_deferred("transport_hero", body as Hero)


func _on_Teleport_body_exited(body: PhysicsBody2D) -> void:
	if not is_exit:
		return
	# reset the exit
	is_exit = false
