tool
extends ViewportContainer


var providers : Array = []

var nscale : float = 1
var minimap : Node2D

var follow : Node2D



#==== node functions ====
func _ready() -> void:
	_set_viewport_size(rect_size)
	
	if U.in_editor():
		return
	set_process(false)
	providers = get_tree().get_nodes_in_group(C.GROUP_MINIMAP_PROVIDER)
	setup_minimap()
	setup_pointer()
	

func _process(delta: float) -> void:
	
	$Viewport/MinimapPointer.global_position = follow.global_position / (nscale * 2 ) 


#==== functions ====
func setup_minimap() -> void:
	if not providers or providers.empty():
		return 
	
	var p : MinimapProvider = providers[0]
	if not p.minimap:
		return 
		
	minimap = p.minimap.instance()
	minimap.scale /= p.nscale
	nscale = p.nscale
	
	$Viewport.add_child(minimap)


func setup_pointer() -> void:
	$Viewport/MinimapPointer.scale /= nscale
	$Viewport/MinimapPointer.scale *= 2
	var heroes := get_tree().get_nodes_in_group(C.GROUP_HERO)
	
	if not heroes or heroes.empty():
		set_process(false)
		return 
	
	follow = heroes[0]
	set_process(true)







#==== setters ====
func _set_viewport_size(size : Vector2 = Vector2()) -> void:
	if not U.in_editor():
		return
	$Viewport.size = size




#==== signals ====
#=== tool ===
func _on_MinimapContainer_item_rect_changed() -> void:
	_set_viewport_size(rect_size)
