extends Resource
class_name CTEnemySource

export(bool) var passive : bool = false
export(float, 0, 1000) var mass : float = 100
export(float, 0, 1000, 10) var movement_speed : float = 400

#==== body ====
export(Shape2D) var body_shape : Shape2D
export(Vector2) var body_offset : Vector2 = Vector2()
export(float, 0, 360, 0.5) var body_rotation : float = 0

#==== sprite ====
export(Texture) var sprite : Texture

#==== view ====
export(Shape2D) var view_shape : Shape2D
export(Vector2) var view_offset : Vector2 = Vector2()
export(float, 0, 360, 0.5) var view_rotation : float = 0