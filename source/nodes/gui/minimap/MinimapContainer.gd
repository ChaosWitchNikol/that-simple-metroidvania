tool
extends ViewportContainer


var minimaps : Array = []



#==== node functions ====
func _ready() -> void:
	_set_viewport_size(rect_size)
	
	if U.in_editor():
		return
	
	minimaps = get_tree().get_nodes_in_group(C.GROUP_MINIMAP_PROVIDER)
	





#==== setters ====
func _set_viewport_size(size : Vector2 = Vector2()) -> void:
	if not U.in_editor():
		return
	$Viewport.size = size



#==== signals ====
#=== tool ===
func _on_MinimapContainer_item_rect_changed() -> void:
	_set_viewport_size(rect_size)
