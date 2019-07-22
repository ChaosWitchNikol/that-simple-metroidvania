tool
extends Node2D
class_name ToolEnemyEdit

# TODO: preview animations
export(Resource) var resource : Resource

#==== node functions ====
func _ready() -> void:
	print(">>> ToolEnemyEdit ready")
	init_resource()

func _enter_tree() -> void:
	print(">>> ToolEnemyEdit enter tree")
	init_resource()

func _process(delta: float) -> void:
	if not resource:
		return
		
	_preview_transform_shape($Body, resource.body) # preview body
	_preview_transform_shape($View, resource.view) # preview view
	_preview_transform_shape($AttackRange, resource.attack_range) # preview attack range
	
	_preview_animation_sprite($EnemySprite, resource.sprite) # preview sprite
	
	# attack
	_preview_shape2D($AttackEdit/AttackArea, resource.attack.area)
	_preview_sprite($AttackEdit/AttackSprite, resource.attack.sprite)
	pass


func init_resource() -> void:
	if not resource:
		var new_resource : ResEnemy = ResEnemy.new()
		new_resource.body = ResTransformShape2D.new()
		new_resource.view = ResTransformShape2D.new()
		new_resource.attack_range = ResTransformShape2D.new()
		new_resource.attack = ResAttack.new()
		new_resource.animations = ResAnimationsEnemy.new()
		new_resource.sprite = ResAnimationSprite.new()
		
		resource = new_resource
	else:
		pass



#==== preview functions ====
func _preview_transform_shape(node: DrawShape2D, shape : ResTransformShape2D) -> void:
	node.shape = shape.shape
	node.position = shape.offset
	node.rotation_degrees = shape.rotation_degrees

func _preview_animation_sprite(node : Sprite, sprite : ResAnimationSprite) -> void:
	node.texture = sprite.texture
	node.vframes = sprite.vframes
	node.hframes = sprite.hframes

func _preview_shape2D(node : DrawShape2D, shape: Shape2D) -> void:
	node.shape = shape

func _preview_sprite(node : Sprite, sprite : Texture) -> void:
	node.texture = sprite



#==== signals ====
func _on_resource_changed() -> void:
	print(resource)