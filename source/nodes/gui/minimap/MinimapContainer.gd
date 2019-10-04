tool
extends ViewportContainer


var providers : Array = []



#==== node functions ====
func _ready() -> void:
	_set_viewport_size(rect_size)
	
	if U.in_editor():
		return
	
	providers = get_tree().get_nodes_in_group(C.GROUP_MINIMAP_PROVIDER)
	setup_minimap()
	


#==== functions ====
func setup_minimap() -> void:
	if not providers or providers.empty():
		return 
	
	var p : MinimapProvider = providers[0]
	if not p.minimap:
		return 
		
	var minimap : Node2D = p.minimap.instance()
	minimap.scale /= p.nscale
	
	$Viewport.add_child(minimap)






#==== setters ====
func _set_viewport_size(size : Vector2 = Vector2()) -> void:
	if not U.in_editor():
		return
	$Viewport.size = size




#==== signals ====
#=== tool ===
func _on_MinimapContainer_item_rect_changed() -> void:
	_set_viewport_size(rect_size)
