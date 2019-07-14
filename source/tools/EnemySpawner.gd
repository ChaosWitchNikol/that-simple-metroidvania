tool
extends Node2D
class_name TEnemySpawner

#==== signals ====
signal _t_enemy_spawner_export_var_change

#==== enemy instance variables ====
#== exports ==
export(Resource) var enemy_source : Resource setget _set_enemy_source
export(PackedScene) var enemy_scene : PackedScene  
export(C.FACING) var enemy_facing : int = C.FACING.RIGHT setget _set_enemy_facing
export(float) var gravity_value : float = C.GRAVITY_VALUE
export(C.GRAVITY_DIRECTION) var gravity_direction : int = C.GRAVITY_DIRECTION.DOWN setget _set_gravity_direction
export(float, 0.01, 2048, 0.01) var respawn_timeout : float = 20
export(bool) var respawn_disabled : bool = false
#== variables ==
var gravity_vector : Vector2 = U.gravity_direction2vector(gravity_direction)

#==== preview ====
export(Texture) var _preview_image : Texture setget _set_preview_image
export(bool) var _preview_hide : bool = false setget _set_preview_hide

#==== spawn point variables ====
var instance

#==== node functions ====
func _ready() -> void:
	if Engine.editor_hint:
		if enemy_source and not enemy_source.is_connected("ct_enemy_source_changed", self, "_on_enemy_source_change"):
			enemy_source.connect("ct_enemy_source_changed", self, "_on_enemy_source_change")
	else:
		get_node("EnemyPreview").visible = false
		get_node("EnemyPreview").queue_free()
		
		if not enemy_source or not enemy_scene:
			queue_free()
			return
		
		spawn_enemy()

#==== custom functions ====
func spawn_enemy() -> void:
	if instance:
		return
	# create new instance
	instance = enemy_scene.instance()
	# set all instance variables
	#	set gravity variables
	instance.gravity_value = gravity_value
	instance.gravity_vector = gravity_vector
	instance.mass = enemy_source.mass
	print(instance.mass)
	#	set movement variables
	instance.movement_speed = enemy_source.movement_speed
	instance.facing = enemy_facing
	#	set life variables
	instance.passive = enemy_source.passive
	#	set body node variables
	instance.get_node("Body").shape = enemy_source.body_shape
	instance.get_node("Body").position = enemy_source.body_offset
	instance.get_node("Body").rotation_degrees = enemy_source.body_rotation
	#	set view node variables
	instance.get_node("View/ViewShape").shape = enemy_source.view_shape
	instance.get_node("View").position = enemy_source.view_offset
	instance.get_node("View/ViewShape").rotation_degrees = enemy_source.view_rotation
	#	set enemy sprite node
	instance.get_node("EnemySprite").texture = enemy_source.sprite
	

	# finally add child
	add_child(instance)


#==== setters ====
func _set_enemy_source(value : Resource) -> void:
	if Engine.editor_hint and not value:
		if enemy_source and enemy_source.is_connected("ct_enemy_source_changed", self, "_on_enemy_source_change"):
			enemy_source.disconnect("ct_enemy_source_changed", self, "_on_enemy_source_change")
	
	enemy_source = value
	
	if Engine.editor_hint:
		if enemy_source and not enemy_source.is_connected("ct_enemy_source_changed", self, "_on_enemy_source_change"):
			enemy_source.connect("ct_enemy_source_changed", self, "_on_enemy_source_change")
		emit_signal("_t_enemy_spawner_export_var_change")

func _set_enemy_facing(value : int = C.FACING.RIGHT) -> void:
	enemy_facing = value
	if Engine.editor_hint:
		emit_signal("_t_enemy_spawner_export_var_change")

func _set_gravity_direction(value : int = C.GRAVITY_DIRECTION.DOWN) -> void:
	gravity_direction = value
	gravity_vector = U.gravity_direction2vector(value)
	if Engine.editor_hint:
		emit_signal("_t_enemy_spawner_export_var_change")

func _set_preview_image(value : Texture) -> void:
	_preview_image = value
	if Engine.editor_hint:
		emit_signal("_t_enemy_spawner_export_var_change")

func _set_preview_hide(value : bool) -> void:
	_preview_hide = value
	if Engine.editor_hint:
		emit_signal("_t_enemy_spawner_export_var_change")


#==== signals ====
#== editor specific signals ==
func _on_enemy_source_change() -> void:
	emit_signal("_t_enemy_spawner_export_var_change")