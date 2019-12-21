extends AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
#	play("MoveLeft")
	var trrr = get_node("../AnimationTree")
	var playback = trrr.get("parameters/playback")
	playback.start("Idle")
	trrr.active = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
