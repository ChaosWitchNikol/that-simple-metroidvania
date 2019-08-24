extends Node
class_name Region


export(NodePath) var start_zone_path : NodePath

var current_zone
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if start_zone_path:
		current_zone = get_node(start_zone_path).create_instance()
	# connect teleports signals
	for teleport in $Teleports.get_children():
		(teleport as Teleport).connect("teleport_entered", self, "_on_teleport_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


#==== signals ====
func _on_teleport_entered(teleport: Teleport) -> void:
	$Zones.remove_child(current_zone)
	current_zone = teleport.get_target_teleport_zone_placeholder().create_instance()