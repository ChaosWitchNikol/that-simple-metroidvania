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
	print("export changed")
	var p : TEnemySpawner = get_parent() as TEnemySpawner
	var src : CTEnemySource = p.enemy_source as CTEnemySource
	visible = not p._preview_hide
	get_node("Sprite").texture = p._preview_image
	# set view
	get_node("View").shape = src.view_shape
	get_node("View").rotation_degrees = src.view_rotation
	get_node("View").position = src.view_offset
	
