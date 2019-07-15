tool
extends Node
class_name PreviewController

const GROUP_ENEMY_PREVIEW : String = "tool_enemy_preview"
const GROUP_PLATFORM_PATH : String = "tool_platform_path"

#==== enemy previews ====
export(bool) var enemies : bool = true setget set_enemies
export(bool) var enemy_sprite : bool = true setget set_enemy_sprite
export(bool) var enemy_view : bool = true setget set_enemy_view
export(bool) var enemy_body : bool = true setget set_enemy_body

#==== platform preview ====
export(bool) var platform_path : bool = true setget set_platform_path
export(bool) var platform_movement : bool = false

#==== node functions ====
func _ready() -> void:
	if not Engine.editor_hint:
		queue_free()

#==== cutom funcitons ====
func update_enemy_previews_node(node_name : String, visibility : bool) -> void:
	for enemy_preview in get_tree().get_nodes_in_group(GROUP_ENEMY_PREVIEW):
		enemy_preview.get_node(node_name).visible = visibility

func update_path_previews_node(variable : String, visibility : bool) -> void:
	for platform_path in get_tree().get_nodes_in_group(GROUP_PLATFORM_PATH):
		platform_path.set(variable, visibility)


#==== setters ====
#===== enemy =====
func set_enemies(value : bool) -> void:
	enemies = value
	set_enemy_sprite(value)
	self.enemy_view = value
	self.enemy_body = value

func set_enemy_sprite(value : bool) -> void:
	enemy_sprite = value
	update_enemy_previews_node("Sprite", value)

func set_enemy_view(value : bool) -> void:
	enemy_view = value
	update_enemy_previews_node("View", value)

func set_enemy_body(value : bool) -> void:
	enemy_body = value
	update_enemy_previews_node("Body", value)
#===== platform path =====
func set_platform_path(value : bool) -> void:
	platform_path = value
	update_path_previews_node("preview_path", value)

