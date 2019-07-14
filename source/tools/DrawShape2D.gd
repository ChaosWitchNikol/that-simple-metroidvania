tool
extends Node2D
class_name DrawShape2D

export(Color) var color : Color = "#FFFFFF" setget set_color
export(bool) var fill : bool = false setget set_fill
export(float, 0, 1) var opacity : float = 0.5 setget set_opacity
export(Shape2D) var shape : Shape2D setget set_shape

#==== node functions ====
func _ready() -> void:
	set_color()
	shape.connect("changed", self, "_on_shape_changed")

func _draw() -> void:
	if shape is RectangleShape2D:
		shape2d_rectangle()
	elif shape is CircleShape2D:
		shape2d_circle()
	elif shape is CapsuleShape2D:
		shape2d_capsule()
	else:
		pass

#==== shape drawing functions ====
func shape2d_capsule() -> void:
	var pos : Vector2 = position
	var capsule = shape as CapsuleShape2D
	var height_vector : Vector2 = Vector2(0, capsule.height / 2)
	var radius_vector : Vector2 = Vector2(capsule.radius, 0)
	if not fill:
		# draw top arc
		draw_circle_arc(pos - height_vector, capsule.radius, -90, 90, color)
		# draw bottom arc
		draw_circle_arc(pos + height_vector, capsule.radius, 90, 270, color)
		
		if capsule.height > 0.0:
			# right side
			draw_line(pos + radius_vector - height_vector, pos + radius_vector + height_vector, color)
			# left side
			draw_line(pos - radius_vector - height_vector, pos - radius_vector + height_vector, color)
	else:
		# draw top arc
		draw_circle_arc_poly(pos - height_vector, capsule.radius, -90, 90, color)
		# draw bottom arc
		draw_circle_arc_poly(pos + height_vector, capsule.radius, 90, 270, color)
		if capsule.height > 0.0:
			var points : PoolVector2Array = PoolVector2Array([
					pos + radius_vector - height_vector, 
					pos + radius_vector + height_vector,
					pos - radius_vector + height_vector,
					pos - radius_vector - height_vector
			])
			draw_polygon(points, PoolColorArray([color]))

func shape2d_circle() -> void:
	var circle = shape as CircleShape2D
	if not fill: 
		draw_circle_arc(position, circle.radius, 0, 360, color)
	else:
		draw_circle_arc_poly(position, circle.radius, 0, 360, color)

func shape2d_rectangle() -> void:
	var rectangle = shape as RectangleShape2D
	draw_rect(Rect2(position - rectangle.extents, rectangle.extents * 2), color, fill)


#==== custom drawing functions ====
func draw_circle_arc(center : Vector2, radius : float, angle_start : float, angle_end : float, color : Color) -> void:
	var nb_points : int = 32
	var points_arc : PoolVector2Array = PoolVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_start + i * (angle_end - angle_start) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func draw_circle_arc_poly(center : Vector2, radius: float, angle_start : float, angle_end : float, color: Color) -> void:
	var nb_points : int = 32
	var points_arc : PoolVector2Array = PoolVector2Array()
	points_arc.push_back(center)
	var colors : PoolColorArray = PoolColorArray([color])
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_start + i * (angle_end - angle_start) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	
	draw_polygon(points_arc, colors)


#==== setters ====
func set_color(value : Color = "#FFFFFF") -> void:
	color = value
	color.a = opacity
	update()

func set_fill(value : bool = false) -> void:
	fill = value
	update()

func set_opacity(value: float = 0.5) -> void:
	opacity = value
	color.a = opacity
	update()

func set_shape(value: Shape2D) -> void:
	shape = value
	update()



#==== signals ====
func _on_shape_changed() -> void:
	update()