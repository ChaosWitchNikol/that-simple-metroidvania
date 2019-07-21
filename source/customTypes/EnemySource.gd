tool
extends Resource
class_name CTEnemySource

#==== signals ====
signal ct_enemy_source_changed


export(bool) var passive : bool = false setget _set_passive
export(float, 0, 1000) var mass : float = 100 setget _set_mass
export(float, 0, 1000, 10) var movement_speed : float = 400 setget _set_movement_speed

#==== body ====
export(Shape2D) var body_shape : Shape2D setget _set_body_shape
export(Vector2) var body_offset : Vector2 = Vector2() setget _set_body_offset
export(float, 0, 360, 0.5) var body_rotation : float = 0 setget _set_body_rotation

#==== sprite ====
export(Texture) var sprite : Texture setget _set_sprite

#==== view ====
export(Shape2D) var view_shape : Shape2D setget _set_view_shape
export(Vector2) var view_offset : Vector2 = Vector2() setget _set_view_offset
export(float, 0, 360, 0.5) var view_rotation : float = 0 setget _set_view_rotation

#==== attack ====
export(Shape2D) var attack_range_shape : Shape2D
export(Vector2) var attack_range_offset : Vector2 = Vector2()
export(Resource) var attack : Resource


#==== setters ====
func _set_passive(value : bool = false) -> void:
	passive = value
	emit_signal("ct_enemy_source_changed")

func _set_mass(value : float = 100) -> void:
	mass = value
	emit_signal("ct_enemy_source_changed")

func _set_movement_speed(value : float = 400) -> void:
	movement_speed = value
	emit_signal("ct_enemy_source_changed")

func _set_body_shape(value : Shape2D) -> void:
	body_shape = value
	emit_signal("ct_enemy_source_changed")

func _set_body_offset(value : Vector2 = Vector2()) -> void:
	body_offset = value
	emit_signal("ct_enemy_source_changed")

func _set_body_rotation(value : float = 0) -> void:
	body_rotation = value
	emit_signal("ct_enemy_source_changed")

func _set_sprite(value : Texture) -> void:
	sprite = value
	emit_signal("ct_enemy_source_changed")

func _set_view_shape(value : Shape2D) -> void:
	view_shape = value
	emit_signal("ct_enemy_source_changed")

func _set_view_offset(value : Vector2 = Vector2()) -> void:
	view_offset = value
	emit_signal("ct_enemy_source_changed")

func _set_view_rotation(value : float = 0) -> void:
	view_rotation = value
	emit_signal("ct_enemy_source_changed")

