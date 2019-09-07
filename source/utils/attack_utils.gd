extends Node
class_name AttackUtils




static func apply_efects_to_node2D(node : Node2D, effects : Array) -> void:
	if not node or not effects:
		return
	
	if node.has_node("AttackHandler"):
		node.get_node("AttackHandler").recieve_attack(effects)
	else:
		var handler
		for child in node.get_children():
			if child.get_class() == "AttackHandler" and not handler:
				handler = child
				break
		handler.recieve_attack(effects)
