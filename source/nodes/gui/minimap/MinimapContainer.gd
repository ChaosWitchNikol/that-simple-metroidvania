tool
extends ViewportContainer


export(Color) var hero_color : Color = "#ffd100"


onready var hero_pointer := $Viewport/HeroPointer

var providers : Array = []

var nscale : float = 1
var minimap : Node2D




#==== node functions ====
func _ready() -> void:
	set_process(false)
#	_set_viewport_size(rect_size)
	
	if U.in_editor():
		set_process(true)
		return
	providers = get_tree().get_nodes_in_group(C.GROUP_MINIMAP_PROVIDER)
	setup_minimap()
	setup_pointer()
	


func _process(delta: float) -> void:
	if not U.in_editor():
		return
	
	if $Viewport.size.x != rect_size.x or $Viewport.size.y != rect_size.y:
		$Viewport.size = rect_size
	


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
	var heroes := get_tree().get_nodes_in_group(C.GROUP_HERO)
	
	if not heroes or heroes.empty():
		set_process(false)
		return 
	
	hero_pointer.setup(heroes[0], nscale, hero_color)






#==== setters ====
func _set_viewport_size(size : Vector2 = Vector2()) -> void:
	if not U.in_editor():
		return
	$Viewport.size = size

func set_rect_size(size: Vector2) -> void:
	rect_size = size
	print(size)



