tool
extends Node2D
class_name EnemyPreview_Tool, "res://assets/icons/icon_preview.svg"


var parent : EnemySpawnPoint

#==== node functions ====
func _enter_tree() -> void:
	set_process(false)
	if not U.in_editor():
		visible = false
		set_process(false)
		queue_free()
	else:
		var parent = get_parent()
		if not parent or not (parent is EnemySpawnPoint):
			set_process(false)
			print("> preview: ", name, " parent: ", parent)
			return
		else:
			self.parent = parent
			var tree : SceneTree = get_tree()
			if tree:
				var preview_controlls : Array = tree.get_nodes_in_group("preview_control")
				if preview_controlls and preview_controlls.size() > 0:
					var control : PreviewControl_Tool = preview_controlls[0]
					get_node("Body").visible = control.enemy_body
					get_node("Peek").visible = control.enemy_sprite
					get_node("View").visible = control.enemy_view
			set_process(true)
func _ready() -> void:
	set_process(false)
	if not U.in_editor():
		visible = false
		set_process(false)
		queue_free()
	else:
		var parent = get_parent()
		if not parent or not (parent is EnemySpawnPoint):
			set_process(false)
			print("> preview: ", name, " parent: ", parent)
			return
		else:
			self.parent = parent
			var tree : SceneTree = get_tree()
			if tree:
				var preview_controlls : Array = tree.get_nodes_in_group("preview_control")
				if preview_controlls and preview_controlls.size() > 0:
					var control : PreviewControl_Tool = preview_controlls[0]
					get_node("Body").visible = control.enemy_body
					get_node("Peek").visible = control.enemy_sprite
					get_node("View").visible = control.enemy_view
			set_process(true)

func _process(delta: float) -> void:
	if not parent.enemy_source:
		return
	var enemy_source = parent.get('enemy_source')
	preview_peek(enemy_source)
	preview_view(enemy_source)
	preview_body(enemy_source)


#==== custom functions ====
func preview_peek(src : ResEnemy) -> void:
	if not src.sprite:
		return
	var peek : Sprite = get_node("Peek")
	if peek.texture != src.sprite.texture:
		peek.texture = src.sprite.texture
	peek.flip_h = parent.enemy_facing == C.FACING.LEFT

func preview_view(src : ResEnemy) -> void:
	if not src.view or not src.view.shape:
		return
	var view = get_node("View")
	if not view.visible:
		return
	if view.shape != src.view.shape:
		view.shape = src.view.shape
	if view.position != src.view.offset:
		view.position = src.view.offset
	if view.rotation_degrees != src.view.rotation_degrees:
		view.rotation_degrees = src.view.rotation_degrees
		
	view.position.x = abs(src.view.offset.x) * parent.enemy_facing

func preview_body(src: ResEnemy) -> void:
	if not src.body or not src.body.shape:
		return
	var body = get_node("Body")
	if not body.visible:
		return
	
	if body.shape != src.body.shape:
		body.shape = src.body.shape
	
	if body.position != src.body.offset:
		body.position = src.body.offset

	if body.rotation_degrees != src.body.rotation_degrees:
		body.rotation_degrees = src.body.rotation_degrees