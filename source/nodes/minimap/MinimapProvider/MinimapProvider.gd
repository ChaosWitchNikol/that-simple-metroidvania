extends Node2D
class_name MinimapProvider


export(float, 0, 8192, 0.00001 ) var nscale : float = 1

#==== node functions ====
func _enter_tree() -> void:
	U.add_node_to_groups(self, [C.GROUP_MINIMAP, C.GROUP_MINIMAP_PROVIDER])


func _ready() -> void:
	print(get_groups())