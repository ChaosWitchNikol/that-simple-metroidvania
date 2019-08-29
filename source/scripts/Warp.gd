tool
extends Area2D
class_name Warp

export(PackedScene) var next_scene : PackedScene

export(bool) var force_interaction : bool = true setget _set_force_interaction


var hero : Hero



#==== setters ====
func _set_force_interaction(value: bool) -> void:
	force_interaction = value
	$WarpCollision.disabled = !value


#==== signals ====
func _on_Warp_body_entered(body: PhysicsBody2D) -> void:
	if body is Hero:
		hero = body as Hero
		if not force_interaction:
			get_tree().change_scene_to(next_scene)
