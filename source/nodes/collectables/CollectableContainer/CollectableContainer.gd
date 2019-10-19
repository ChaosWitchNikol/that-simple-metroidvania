tool
extends Area2D
class_name CollectableContainer

signal collected


export(Resource) var item : Resource
export(bool) var persist : bool = false



func _on_CollectableContainer_body_entered(body: PhysicsBody2D) -> void:
	if body is Hero:
		emit_signal("collected", item)
		queue_free()




