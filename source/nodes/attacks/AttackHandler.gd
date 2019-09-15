extends HandlerNode
class_name AttackHandler

const EffectDurationScene : PackedScene = preload("res://nodes/attacks/EffectDuration.tscn")

signal cooled_down

#==== exports ====
export(PackedScene) var attack_scene : PackedScene
export(float, 0.01, 4096, 0.01) var cooldown : float = 0.01 
export(bool) var is_emitter : bool = true
export(bool) var is_reciever : bool = true


var available_variables : Dictionary = {
	"health": true,
	"movement_speed": true
}

#==== node functions ====
func _ready() -> void:
	# do precheck in case the parent is missing some life variables
	available_variables.health = "health" in P
	available_variables.movement_speed = "movement_speed" in P
	print(P.name, " AttackHandler ", available_variables, " emmiter: ", is_emitter, " reviever: ", is_reciever)
	



#==== functions ====
func emit_attack(target : Node2D) -> void:
	if not is_emitter or not $AttackCooldown.is_stopped():
		return
	
	var attack := attack_scene.instance()
	attack.assemble(P)
	if attack.get_class() == "AttackBullet":
		get_tree().get_root().add_child(attack)
		attack.fire_bullet(target.global_position, P.global_position)
	elif attack.get_class() == "Attack":
		get_tree().get_root().add_child(attack)
		attack.execute_on(target)
		attack.queue_free()
	
	$AttackCooldown.start(cooldown)



func recieve_attack(effects : Array) -> void:
	if not is_reciever:
		return
	
	for effect in effects:
		if not available_variables.has(effect.variable) or not available_variables.get(effect.variable):
			continue
		P.set(effect.variable, P.get(effect.variable) + effect.value)
		if effect.duration > 0:
			var effect_duration := EffectDurationScene.instance()
			effect_duration.assemble(P, effect)
			P.add_child(effect_duration)



#==== getters ====
func get_class() -> String:
	return "AttackHandler"



#==== signals ====
func _on_AttackCooldown_timeout() -> void:
	emit_signal("cooled_down")
