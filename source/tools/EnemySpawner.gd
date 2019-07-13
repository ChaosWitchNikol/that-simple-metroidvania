tool
extends Node2D
class_name TEnemySpawner


#==== enemy instance variables ====
#== exports ==
export(Resource) var enemy_source : Resource setget _set_enemy_source
export(PackedScene) var enemy_scene : PackedScene setget _set_enemy_scene
export(C.FACING) var enemy_facing : int = C.FACING.RIGHT
export(float) var gravity_value : float = C.GRAVITY_VALUE
export(C.GRAVITY_DIRECTION) var gravity_direction : int = C.GRAVITY_DIRECTION.DOWN setget _set_gravity_direction
export(float, 0.01, 2048, 0.01) var respawn_timeout : float = 20
export(bool) var respawn_disabled : bool = false
#== variables ==
var gravity_vector : Vector2 = U.gravity_direction2vector(gravity_direction)

#==== preview ====
export(Texture) var _preview_image : Texture setget _set_preview_image
export(bool) var _preview_hide : bool = false setget _set_preview_hide


func _ready() -> void:
	if Engine.editor_hint:
		pass
	else:
		get_node("EnemyPreview").visible = false
		get_node("EnemyPreview").queue_free()


#==== setters ====
func _set_enemy_source(value : Resource) -> void:
	enemy_source = value
	get_node("EnemyPreview").source = value

func _set_enemy_scene(value : PackedScene) -> void:
	enemy_scene = value
	print(value.resource_name)

func _set_gravity_direction(value : int = C.GRAVITY_DIRECTION.DOWN) -> void:
	gravity_direction = value
	gravity_vector = U.gravity_direction2vector(value)

func _set_preview_image(value : Texture) -> void:
	_preview_image = value
	get_node("EnemyPreview/Sprite").texture = _preview_image

func _set_preview_hide(value : bool) -> void:
	_preview_hide = value
	get_node("EnemyPreview").visible = not value

#==== signals ====
