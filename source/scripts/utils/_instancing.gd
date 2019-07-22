extends Object
class_name I


#==== effects ====
#=== attack ===
static func attack_source2instance(source : CTAttack, scene : PackedScene) -> Attack:
	if not source:
		return null
	# create blank instance
	var instance : Attack =  scene.instance()
	# set instance variables
	instance.effects = source.effects
	instance.max_targets = source.max_targets
	instance.movement_speed = source.movement_speed
	# set children nodes
	instance.get_node("AttackArea").shape = source.area
	instance.get_node("AttackSprite").texture = source.sprite
	return instance

static func enemy_src2inst(src : ResEnemy, scene : PackedScene) -> EnemyBase:
	if not src or not scene:
		return null
	
	var inst : EnemyBase = scene.instance()
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
	inst.get_node("AttackRange/AttackRAngeShape").shape = src.attack_range.shape
	inst.get_node("AttackRange/AttackRAngeShape").rotation_degrees = src.attack_range.rotation_degrees
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
