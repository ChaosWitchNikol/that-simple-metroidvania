tool
extends Node2D
class_name TEnemyPreview


var sprite : Texture
var source : Resource

func _ready() -> void:
	if not Engine.editor_hint:
		visible = false
		queue_free()



