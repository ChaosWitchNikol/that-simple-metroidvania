extends Node
class_name In

#==== effects ====
#=== attack ===
static func attack_source2instance(source : CTAttack_old, scene : PackedScene) -> Attack_old:
	if not source:
		return null
	# create blank instance
	var instance : Attack_old =  scene.instance()
	# set instance variables
	instance.effects = source.effects
	instance.max_targets = source.max_targets
	instance.movement_speed = source.movement_speed
	# set children nodes
	instance.get_node("AttackArea").shape = source.area
	instance.get_node("AttackSprite").texture = source.sprite
	return instance

static func enemy_src2inst(src : ResEnemy_old, scene : PackedScene):
	if not src or not scene:
		return null
	
	var inst := scene.instance()
	# set variables
	inst.passive = src.is_passive
	inst.mass = src.mass
	inst.movement_speed = src.movement_speed
	# set body
	inst.get_node("Body").shape = src.body.shape
	inst.get_node("Body").position = src.body.offset
	inst.get_node("Body").rotation_degrees = src.body.rotation_degrees
	# set view
	inst.get_node("View/ViewShape").shape = src.view.shape
	inst.get_node("View/ViewShape").rotation_degrees = src.view.rotation_degrees
	inst.get_node("View").position = src.view.offset
	# set sprite
	inst.get_node("EnemySprite").texture = src.sprite.texture
	inst.get_node("EnemySprite").hframes = src.sprite.hframes
	inst.get_node("EnemySprite").vframes = src.sprite.vframes
	# set attack range
	inst.get_node("AttackRange/AttackRangeShape").shape = src.attack_range.shape
	inst.get_node("AttackRange/AttackRangeShape").rotation_degrees = src.attack_range.rotation_degrees
	inst.get_node("AttackRange").position = src.attack_range.offset
	# set attack
	inst.attack = src.attack
	# set animations
	var animation_player : AnimationPlayer = inst.get_node("Anims")
	_set_animation(animation_player, "idle", src.animations.idle)
	_set_animation(animation_player, "move", src.animations.move)
	_set_animation(animation_player, "attack", src.animations.attack)
	
	return inst
	
#==== helpers ====
static func _set_animation(player: AnimationPlayer, name : String, animation : Animation) -> void:
	if not name or not player or not animation:
		return
	if player.has_animation(name):
		player.remove_animation(name)
	player.add_animation(name, animation)
