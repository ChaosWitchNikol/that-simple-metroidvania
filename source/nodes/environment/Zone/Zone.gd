tool
extends Node2D
class_name Zone


func _enter_tree() -> void:
	# if U.in_editor():
	if not get_scene_instance_load_placeholder():
		set_scene_instance_load_placeholder(true)
		

func _get_configuration_warning() -> String:
	if not get_scene_instance_load_placeholder():
		return "Zone [ " + name + " ] is not set as \"Load As Placeholder\""
	return ""