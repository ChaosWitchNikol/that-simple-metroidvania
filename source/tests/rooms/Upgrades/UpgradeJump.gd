extends _TestRoom



var initial_hero_pos : Vector2 = Vector2()
var max_hero_pos : Vector2 = Vector2()


func _ready() -> void:
	initial_hero_pos = $Hero.global_position
	max_hero_pos = $Hero.global_position
	print(initial_hero_pos, max_hero_pos)


func _process(delta: float) -> void:
	# update jump force label
	$CanvasLayer/JumpForce.text = str($Hero.jump_force)
	
	
	# record highest hero position
	if $Hero.global_position.y < max_hero_pos.y:
		max_hero_pos = $Hero.global_position
	
	
	# update max height
	$CanvasLayer/MaxHeight.text = str(round((initial_hero_pos.y - max_hero_pos.y) / C.TILE_SIZEF))
	
	# update current height
	$CanvasLayer/Height.text = str(round((initial_hero_pos.y - $Hero.global_position.y) / C.TILE_SIZEF))
	
