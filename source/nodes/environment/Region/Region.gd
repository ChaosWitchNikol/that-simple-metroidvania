extends Node
class_name Region


export(NodePath) var start_zone_path : NodePath

var current_zone
var previous_zone

#==== node functions ====
func _ready() -> void:
	if start_zone_path:
		current_zone = get_node(start_zone_path).create_instance()
	# connect teleports signals
	for teleport in $Teleports.get_children():
		(teleport as Teleport).connect("teleport_entered", self, "_on_teleport_entered")
		(teleport as Teleport).connect("teleport_exited", self, "_on_teleport_exited")




#==== signals ====
func _on_teleport_entered(teleport: Teleport) -> void:
	previous_zone = current_zone
	var zone_placeholder = teleport.get_target_teleport_zone_placeholder()
	if not zone_placeholder:
		print(teleport.name, " target no zone placeholder")
		return
	current_zone = zone_placeholder.create_instance()

func _on_teleport_exited(teleport : Teleport) -> void:
	$Zones.remove_child(previous_zone)