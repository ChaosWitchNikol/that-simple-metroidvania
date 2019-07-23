tool
extends Node2D
class_name Platform


#==== pathway ====
export(NodePath) var pathway_node_path : NodePath setget _set_pathway_node_path
export(NodePath) var start_node_path : NodePath setget _set_start_node_path
var pathway : Pathway
var start : Point


#==== node functions ====
func _ready() -> void:
	pass


#==== setters ====
func _set_pathway_node_path(value : NodePath) -> void:
	if not value:
		pathway_node_path = value
		self.start_node_path = value
		return
	var node := get_node(value)
	if node is Pathway:
		pathway = node as Pathway
		pathway_node_path = value

func _set_start_node_path(value : NodePath) -> void:
	if not value:
		start_node_path = value
		return
	var node := get_node(value)
	if node is Point:
		start = node as Point
		start_node_path = value
		if not pathway_node_path:
			self.pathway_node_path = get_path_to(node.get_parent())
	

#==== signals ====
func _on_PointWait_timeout() -> void:
	set_physics_process(true)
