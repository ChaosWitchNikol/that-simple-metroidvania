tool
extends Node2D
class_name EnemyPreview_Tool


var parent : EnemySpawnPoint

#==== node functions ====
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
func preview_peek(src : CTEnemySource) -> void:
	if not src.sprite:
		return
	var peek : Sprite = get_node("Peek")
	if peek.texture != src.sprite:
		peek.texture = src.sprite
	peek.flip_h = parent.enemy_facing == C.FACING.LEFT

func preview_view(src : CTEnemySource) -> void:
	if not src.view_shape:
		return
	var view = get_node("View")
	if not view.visible:
		return
	if view.shape != src.view_shape:
		view.shape = src.view_shape
	if view.position != src.view_offset:
		view.position = src.view_offset
	if view.rotation_degrees != src.view_rotation:
		view.rotation_degrees = src.view_rotation
		
	view.position.x = abs(src.view_offset.x) * parent.enemy_facing

func preview_body(src: CTEnemySource) -> void:
	if not src.body_shape:
		return
	var body = get_node("Body")
	if not body.visible:
		return
	
	if body.shape != src.body_shape:
		body.shape = src.body_shape
	
	if body.position != src.body_offset:
		body.position = src.body_offset

	if body.rotation_degrees != src.body_rotation:
		body.rotation_degrees = src.body_rotation