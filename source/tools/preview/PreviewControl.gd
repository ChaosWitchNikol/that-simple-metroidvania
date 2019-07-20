tool
extends Node
class_name PreviewControl_Tool, "res://assets/icons/icon_preview_control.svg"

const GROUP_ENEMY_PREVIEW = "enemy_preview"
const GROUP_PATHWAY_PREVIEW = "pathway_preview"
const GROUP_MOVING_PLATFORM_PREVIEW = "moving_platform_preview"

#==== enemy ====
export(bool) var enemy_sprite : bool = true setget _set_enemy_sprite
export(bool) var enemy_view : bool = true setget _set_enemy_view
export(bool) var enemy_body : bool = false setget _set_enemy_body
#==== pathway ====
export(bool) var pathway_path : bool = true setget _set_pathway_path
export(bool) var pathway_handle : bool = true setget _set_pathway_handle
#==== moving platform ====
export(bool) var platform_outline : bool = true setget _set_platform_outline
export(bool) var platform_ghost : bool = true setget _set_platform_ghost


#==== node functions ====
func _enter_tree() -> void:
	if not U.in_editor():
		queue_free()
	else:
		update_enemy_previews()
func _ready() -> void:
	if not U.in_editor():
		queue_free()
	else:
		update_enemy_previews()
		update_pathway_previews()
		update_platform_previews()


#==== custom funcitons ====
#== enemy ==
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
		preview.visible = enemy_sprite or enemy_view or enemy_body
#== pathway ==
func update_pathway_previews() -> void:
	var tree : SceneTree = get_tree()
	if not tree:
		return
	
	var previews : Array = tree.get_nodes_in_group(GROUP_PATHWAY_PREVIEW)
	if not previews or previews.size() == 0:
		return
	
	for preview in previews:
		preview.get_node("Handle").visible = pathway_handle
		preview.hide_path = not pathway_path
		preview.visible = pathway_handle or pathway_path
#== moving platform ==
func update_platform_previews() -> void:
	var tree : SceneTree = get_tree()
	if not tree:
		return
	
	var previews : Array = tree.get_nodes_in_group(GROUP_MOVING_PLATFORM_PREVIEW)
	if not previews or previews.size() == 0:
		return
	
	for preview in previews:
		preview.get_node("Outline").visible = platform_outline
		preview.get_node("Ghost").visible = platform_ghost
		preview.visible = platform_ghost or platform_outline

#==== setters ====
#== enemy ==
func _set_enemy_sprite(value : bool = true) -> void:
	enemy_sprite = value
	update_enemy_previews()

func _set_enemy_view(value : bool = true) -> void:
	enemy_view = value
	update_enemy_previews()

func _set_enemy_body(value : bool = false) -> void:
	enemy_body = value
	update_enemy_previews()
#== pathway ==
func _set_pathway_path(value : bool = true) -> void:
	pathway_path = value
	update_pathway_previews()

func _set_pathway_handle(value : bool = true) -> void:
	pathway_handle = value
	update_pathway_previews()	
#== moving platform ==
func _set_platform_outline(value : bool = true) -> void:
	platform_outline = value
	update_platform_previews()

func _set_platform_ghost(value : bool = true) -> void:
	platform_ghost = value
	update_platform_previews()

