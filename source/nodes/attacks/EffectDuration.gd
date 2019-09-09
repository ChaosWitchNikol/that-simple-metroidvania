extends Timer
class_name EffectDuration


var effect : EffectSrc
var target : Node2D

#==== node functions ====
func _ready() -> void:
	start()


#==== functions ====
func assemble(target : Node2D, effect : EffectSrc) -> void:
	self.target = target
	self.effect = effect
	wait_time = effect.duration
	

func remove_effect() -> void:
	if not target or not effect:
		return
	target.set(effect.variable, target.get(effect.variable) - effect.value)
	queue_free()


func _on_EffectDuration_timeout() -> void:
	call_deferred("remove_effect")
