tool
extends Sprite

const BondaryScene : PackedScene = preload("res://nodes/bounds/Boundary/Bondary.tscn")


var WINDOW_SIZE : Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))

var HALF_WIDTH : int = ProjectSettings.get_setting("display/window/size/width") / 2
var HALF_HEIGHT : int = ProjectSettings.get_setting("display/window/size/height") / 2

var UNIT : Vector2 = texture.get_size()
var HALF_UNIT : Vector2 = UNIT / 2

var MIN_SCALE : Vector2 = Vector2(WINDOW_SIZE.x / UNIT.x, WINDOW_SIZE.y / UNIT.y)



#==== exports ====
export(Color) var color : Color = "#0000FF" setget _set_color
export(Color) var pad_color : Color = "#00FF00" setget _set_pad_color
#== paddings ==
export(int) var pad_top : int = 0 setget _set_pad_top
export(int) var pad_right : int = 0 setget _set_pad_right
export(int) var pad_bot : int = 0 setget _set_pad_bot
export(int) var pad_left : int = 0 setget _set_pad_left



#==== node functions ====
func _ready() -> void:
	if U.in_editor():
		print(HALF_HEIGHT, " ", HALF_WIDTH, " ", UNIT)
		if scale.x < MIN_SCALE.x:
			scale.x = MIN_SCALE.x
		if scale.y < MIN_SCALE.y:
			scale.y = MIN_SCALE.y
	else:
		visible = false
		call_deferred("spawn_boundary")


func _draw() -> void:
	if not U.in_editor():
		return
	
	draw_rect(Rect2(-HALF_UNIT.x, -HALF_UNIT.y, UNIT.x, UNIT.y), color)
	
	var left := -HALF_UNIT.x - (pad_left / scale.x)
	var width := UNIT.x + (pad_left + pad_right) / scale.x
	
	if pad_top > 0:
		var rect := Rect2(left, -HALF_UNIT.y, width, -pad_top / scale.y )
		draw_rect(rect, pad_color)
	
	if pad_right > 0:
		var rect := Rect2(HALF_UNIT.x, -HALF_UNIT.y, pad_right / scale.x, UNIT.y)
		draw_rect(rect, pad_color)
	
	if pad_bot > 0:
		var rect := Rect2(left, HALF_UNIT.y, width, pad_bot / scale.y)
		draw_rect(rect, pad_color)
	
	if pad_left > 0:
		var rect := Rect2(-HALF_UNIT.x, -HALF_UNIT.y, -pad_left / scale.x, UNIT.y)
		draw_rect(rect, pad_color)



#==== functions ====
func spawn_boundary() -> void:
	var instance := BondaryScene.instance()
	instance.assemble(global_position, get_bounds(), _get_rect_extents())
	instance.connect("ready", self, "_on_Boundary_ready")
	get_parent().add_child(instance)



#==== getters ====
func get_bounds_top() -> int:
	return (global_position.y - ( HALF_UNIT.y * scale.y + pad_top )) as int


func get_bounds_right() -> int:
	return (global_position.x + ( HALF_UNIT.x * scale.x + pad_right)) as int


func get_bounds_bot() -> int:
	return (global_position.y + ( HALF_UNIT.y * scale.y + pad_bot )) as int


func get_bounds_left() -> int:
	return (global_position.x - ( HALF_UNIT.x * scale.x + pad_left )) as int


func get_bounds() -> Dictionary:
	return {
		"top" : get_bounds_top(),
		"right" : get_bounds_right(),
		"bot" : get_bounds_bot(),
		"left" : get_bounds_left()
	}


func get_width() -> int:
	return (UNIT.x * scale.x + pad_left + pad_right) as int


func get_height() -> int:
	return (UNIT.y * scale.y + pad_top + pad_bot) as int


func get_top() -> int:
	return ( - HALF_UNIT.y * scale.y - pad_top) as int


func get_right() -> int:
	return( HALF_UNIT.x * scale.x + pad_right) as int


func get_bot() -> int:
	return( HALF_UNIT.y * scale.y + pad_bot) as int
	

func get_left() -> int:
	return (-HALF_UNIT.x * scale.x - pad_left) as int


func _get_rect_extents() -> Vector2:
	return Vector2(HALF_UNIT.x * scale.x, HALF_UNIT.y * scale.y)

func _get_rect_center() -> Vector2:
	return Vector2(
		global_position.x - (pad_left / 2) + (pad_right / 2),
		global_position.y - (pad_top / 2) + (pad_bot / 2)
	)

#==== setters ====
func _set_color(val : Color) -> void:
	val.a = min(val.a, .25)
	color = val
	update()


func _set_pad_color(val : Color) -> void:
	val.a = min(val.a, .25)
	pad_color = val
	update()


func _set_pad_top(val : int) -> void:
	if val == -1:
		val = HALF_HEIGHT
	if val < 0:
		val = 0
	pad_top = val
	update()


func _set_pad_right(val : int) -> void:
	if val == -1:
		val = HALF_WIDTH
	if val < 0:
		val = 0
	pad_right = val
	update()


func _set_pad_bot(val : int) -> void:
	if val == -1:
		val = HALF_HEIGHT
	if val < 0:
		val = 0
	pad_bot = val
	update()


func _set_pad_left(val : int) -> void:
	if val == -1:
		val = HALF_WIDTH
	if val < 0:
		val = 0
	pad_left = val
	update()


func set_scale(value : Vector2) -> void:
	if value.x < MIN_SCALE.x:
		value.x = MIN_SCALE.x
	if value.y < MIN_SCALE.y:
		value.y = MIN_SCALE.y
	
	scale = value 



#==== signals ====
func _on_BoundingRectangle_item_rect_changed() -> void:
	set_scale(scale)


func _on_Boundary_ready() -> void:
	call_deferred("queue_free")