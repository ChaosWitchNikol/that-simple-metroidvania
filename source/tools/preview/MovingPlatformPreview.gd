tool
extends Node2D
class_name MovingPlatformPreview_Tool


var parent : MovingPlatform


#==== node functions ====
func _enter_tree() -> void:
	_setup()

func _ready() -> void:
	_setup()

func _physics_process(delta: float) -> void:
	if not parent:
		return
	
	get_node("Outline").shape.extents.x = parent.tile_width * C.HALF_TILE_SIZE
	get_node("Ghost").shape.extents.x = parent.tile_width * C.HALF_TILE_SIZE

#==== custom functions ====


#==== setup ====
func _setup() -> void:
	set_physics_process(false)
	set_process(false)
	
	if not U.in_editor():
		visible = false
		queue_free()
	else:
		var parent = get_parent()
		if not parent or not (parent is MovingPlatform):
			print("> preview: ", name, " parent: ", parent)
			return
		else:
			self.parent = parent as MovingPlatform
			set_physics_process(true)
			set_process(true)