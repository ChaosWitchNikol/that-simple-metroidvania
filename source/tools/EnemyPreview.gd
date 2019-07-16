tool
extends Node2D
class_name TEnemyPreview


var sprite : Texture
var source : Resource

func _ready() -> void:
	if not Engine.editor_hint:
		visible = false
		queue_free()
	else:
		if get_parent() is TEnemySpawner:
			(get_parent() as TEnemySpawner).connect("_t_enemy_spawner_export_var_change", self, "_on_enemy_spawner_export_var_change")
			_on_enemy_spawner_export_var_change()


func _on_enemy_spawner_export_var_change() -> void:
	var p : TEnemySpawner = get_parent() as TEnemySpawner
	if not p.enemy_source:
		return
	
	var src : CTEnemySource = p.enemy_source as CTEnemySource
	# set sprite
	get_node("Sprite").texture = src.sprite
	
	# set view
	get_node("View").color = "#33ff0000"
	get_node("View").shape = src.view_shape
	get_node("View").rotation_degrees = src.view_rotation
	get_node("View").position = src.view_offset
	
	# set body
	get_node("Body").color = "#330000ff"
	get_node("Body").shape = src.body_shape
	get_node("Body").rotation_degrees = src.body_rotation
	get_node("Body").position = src.body_offset
	
