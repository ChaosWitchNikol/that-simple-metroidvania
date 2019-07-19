tool
extends Node
class_name PreviewControl_Tool, "res://assets/icons/icon_preview_control.svg"

const GROUP_ENEMY_PREVIEW = "enemy_preview"
const GROUP_PATHWAY_PREVIEW = "pathway_preview"


export(bool) var enemy_sprite : bool = true setget _set_enemy_sprite
export(bool) var enemy_view : bool = true setget _set_enemy_view
export(bool) var enemy_body : bool = false setget _set_enemy_body


#==== node functions ====
func _ready() -> void:
	if not U.in_editor():
		queue_free()
		return
	else:
		update_enemy_previews()


#==== custom funcitons ====
func update_enemy_previews() -> void:
	var tree : SceneTree = get_tree()
	if not tree:
		return
	
	var previews : Array = tree.get_nodes_in_group(GROUP_ENEMY_PREVIEW)
	if not previews or previews.size() == 0:
		return
	for preview in previews:
		preview.get_node("Peek").visible = enemy_sprite
		preview.get_node("View").visible = enemy_view
		preview.get_node("Body").visible = enemy_body


#==== setters ====
func _set_enemy_sprite(value : bool = true) -> void:
	enemy_sprite = value
	update_enemy_previews()

func _set_enemy_view(value : bool = true) -> void:
	enemy_view = value
	update_enemy_previews()

func _set_enemy_body(value : bool = false) -> void:
	enemy_body = value
	update_enemy_previews()