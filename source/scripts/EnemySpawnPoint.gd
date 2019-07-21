extends Node2D
class_name EnemySpawnPoint, "res://assets/icons/icon_enemy_spawn_point.svg"


#==== enemy instance variables ====
#== exports ==
export(Resource) var enemy_source : Resource
export(C.ENEMY_TYPE) var enemy_type : int = C.ENEMY_TYPE.WALK setget _set_enemy_type
export(C.FACING) var enemy_facing : int = C.FACING.RIGHT
export(float) var gravity_value : float = C.GRAVITY_VALUE
export(C.GRAVITY_DIRECTION) var gravity_direction : int = C.GRAVITY_DIRECTION.DOWN setget _set_gravity_direction
export(float, 0.01, 2048, 0.01) var respawn_timeout : float = 20 setget _set_respawn_timeout
export(bool) var respawn_disabled : bool = false
#== variables ==
var gravity_vector : Vector2 = U.gravity_direction2vector(gravity_direction)
var enemy_scene : PackedScene = load("res://scenes/EnemyWalk.tscn")


#==== spawn point variables ====
var instance


#==== node functions ====
func _ready() -> void:
	if not enemy_source or not enemy_scene:
		queue_free()
		return
	# connect signals
	get_node("RespawnTimeout").connect("timeout", self, "_on_RespawnTimeout_timeout")
	
	spawn_enemy()


#==== custom functions ====
func spawn_enemy() -> void:
	# create new instance
	instance = enemy_scene.instance()
	# set all instance variables
	#	set gravity variables
	instance.gravity_value = gravity_value
	instance.gravity_vector = gravity_vector
	instance.mass = enemy_source.mass
	#	set movement variables
	instance.movement_speed = enemy_source.movement_speed
	instance.facing = enemy_facing
	#	set life variables
	instance.passive = enemy_source.passive
	#	set body node variables
	instance.get_node("Body").shape = enemy_source.body_shape
	instance.get_node("Body").position = enemy_source.body_offset
	instance.get_node("Body").rotation_degrees = enemy_source.body_rotation
	#	set view node variables
	instance.get_node("View/ViewShape").shape = enemy_source.view_shape
	instance.get_node("View").position = enemy_source.view_offset
	instance.get_node("View/ViewShape").rotation_degrees = enemy_source.view_rotation
	#	set attack node variables
	instance.get_node("AttackRange/AttackRangeShape").shape = enemy_source.attack_range_shape
	instance.get_node("AttackRange").position = enemy_source.attack_range_offset
	#	set enemy sprite node
	instance.get_node("EnemySprite").texture = enemy_source.sprite
	# finally add child
	add_child(instance)
	
	# connect signals
	instance.connect("enemy_died", self, "_on_enemy_died")


#==== setters ====
func _set_enemy_type(value : int = C.ENEMY_TYPE.WALK) -> void:
	enemy_type = value
	if value == C.ENEMY_TYPE.CRAWL:
		enemy_scene = load("res://scenes/EnemyCrawl.tscn")
	elif value == C.ENEMY_TYPE.WALK:
		enemy_scene = load("res://scenes/EnemyWalk.tscn")
	elif value == C.ENEMY_TYPE.FLY:
		enemy_scene = load("res://scenes/EnemyFly.tscn")
	elif value == C.ENEMY_TYPE.STATIC:
		enemy_scene = load("res://scenes/EnemyStatic.tscn")
	else:
		print("Not an enemy type")

func _set_gravity_direction(value : int = C.GRAVITY_DIRECTION.DOWN) -> void:
	gravity_direction = value
	gravity_vector = U.gravity_direction2vector(value)

func _set_respawn_timeout(value : float) -> void:
	respawn_timeout = value
	get_node("RespawnTimeout").wait_time = respawn_timeout


#==== signals ====
#== enemy signals ==
func _on_enemy_died() -> void:
	if not respawn_disabled:
		get_node("RespawnTimeout").call_deferred("start")
#== timer signals ==
func _on_RespawnTimeout_timeout() -> void:
	call_deferred("spawn_enemy")