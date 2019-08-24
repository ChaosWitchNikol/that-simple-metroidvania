tool
extends Area2D
class_name Teleport

#==== target teleport ====
export(NodePath) var target_teleport_path : NodePath
var target_teleport : Teleport
#==== parent zone ====
export(NodePath) var parent_zone_path : NodePath

#==== transition ====
export(float, -1, 1024, 0.01) var transport_duration : float = 1 setget _set_transport_duration
export(float, -1, 16, 0.01) var takeover_duration : float = 0.3 setget _set_takeover_duration

#==== variables ====
var is_exit : bool = false


#==== node functions ====
func _ready() -> void:
	if U.in_editor():
		return
	if not target_teleport_path:
		queue_free()
		return
	target_teleport = get_node(target_teleport_path)





#==== cutom functions ====
func transport_hero(hero : Hero) -> void:
	# TODO: take control away from player
	# TODO: set Cam to hero cam position
	
	# setup
	$Cam.make_current()
	$Cam/BlackOver.self_modulate = Color("00ffffff")
	$Cam/BlackOver.visible = true
	
	# enter the teleport
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, global_position, takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.interpolate_property($Cam/BlackOver, "self_modulate", $Cam/BlackOver.self_modulate, Color("ffffffff"), takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	# move to target location
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, target_teleport.global_position, transport_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	# exit the the teleport
	$CamTweens.interpolate_property($Cam, "global_position", $Cam.global_position, target_teleport.get_exit_position(), takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.interpolate_property($Cam/BlackOver, "self_modulate", $Cam/BlackOver.self_modulate, Color("00ffffff"), takeover_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$CamTweens.start()
	$CamTweens.start()
	yield($CamTweens, "tween_all_completed")
	
	# clear
	$Cam/BlackOver.visible = false
	


#==== getters ====
func get_exit_position() -> Vector2:
	return $ExitPosition.global_position


#==== setters ====
func set_as_exit() -> void:
	is_exit = true

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
		call_deferred("transport_hero", body as Hero)
	

func _on_Teleport_body_exited(body: PhysicsBody2D) -> void:
	if not is_exit:
		return
	# reset the exit
	is_exit = false
