extends Area2D
class_name Trigger

signal triggered

enum TriggerType { ENTER, LEAVE, INTERACT }

export(TriggerType) var type : int = TriggerType.ENTER
 


var can_interact: bool = false

func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("ui_accept"):
		emit_signal("triggered", self)


func _on_Trigger_body_entered(body: PhysicsBody2D) -> void:
	if body.get_class() == C.ClassNames.Hero:
		print(body, body.get_class(), type)
		match type:
			TriggerType.ENTER:
				emit_signal("triggered", self)
			TriggerType.INTERACT:
				can_interact = true

func _on_Trigger_body_exited(body: PhysicsBody2D) -> void:
	if body.get_class() == C.ClassNames.Hero:
		match type:
			TriggerType.LEAVE:
				emit_signal("triggered", self)
			TriggerType.INTERACT:
				can_interact = false
