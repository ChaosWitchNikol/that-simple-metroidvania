extends Object
class_name I

var AttackScene : PackedScene = preload("res://scenes/Attack.tscn") 

#==== effects ====
#=== attack ===
static func attack_source2instance(source : CTEffect) -> Attack:
	# create blank instance
	var instance : Attack =  AttackScene.instance()
	# set instance variables
	instance.effects = source.effects
	instance.max_targets = source.max_targets
	instance.movement_speed = source.movement_speed
	# set children nodes
	instance.get_node("AttackArea").shape = source.area
	instance.get_node("AttackSprite").texture = source.sprite
	return instance