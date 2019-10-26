extends Object
class_name C

#==== tiles ====
const TILE_SIZE : int = 32
const TILE_SIZEF : float = TILE_SIZE * 1.0
const HALF_TILE_SIZE : int = TILE_SIZE / 2
const HALF_TILE_SIZEF : float = TILE_SIZEF / 2.0
const Q_TILE_SIZE : int = TILE_SIZE / 4
const Q_TILE_SIZEF : float = TILE_SIZEF / 4.0

#==== gravity ====
const GRAVITY_VALUE : float = 9.8
const GRAVITY_VECTOR : Vector2 = Vector2(0, 1)
enum GRAVITY_DIRECTION { DOWN = 0, LEFT = 1, UP = 2, RIGHT = 3, NONE = 4}
const GRAVITY_VECTOR_SET = [Vector2.DOWN, Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.ZERO]

#==== movement ====
const FLOOR_VECTOR : Vector2 = Vector2(0, -1)
const SNAP_VECTOR : Vector2 = Vector2(0, 16)
const JUMP_SNAP_VECTOR : Vector2 = Vector2(0, 0)
enum FACING { RIGHT = 1, LEFT = -1 }


#==== enemies ====
enum ENEMY_TYPE { CRAWL = 0, WALK = 1, FLY = 2, STATIC = 3}

#==== effects ====
enum EFFECT_TARGET { HEALTH, MOVEMENT_SPEED }
enum EFFECT_SIGN { PLUS = 1, MINUS = -1}
enum EFFECT_APPLY { IMMEDIATELY, EVERY_TICK }
enum EFFECT_STACK_TYPE { DURATION, VALUE, NONE }



#==== groups ====
#== minimap ==
const GROUP_MINIMAP : String = "g_minimap"
const GROUP_MINIMAP_PROVIDER : String = "g_minimap_provider"
#== bounds ==
#== hero ==
const GROUP_HERO : String = "g_hero"
#== collectable ==
const GROUP_COLLECTABLE : String = "g_collectable"
const GROUP_COLLECTABLE_CONTAINER : String = "g_collectable_container"
const GROUP_COLLECTABLE_HANDLER : String = "g_collectable_handler"

#==== collectables ====
enum COLLECTABLE_TYPE { UPGRADE_VALUE, UPGRADE_FLAG, BOOST_VALUE, WEAPON }



#==== class names ====
class ClassNames:
	#==== handlers ====
	const ValueUpgradeHandler : String = "ValueUpgradeHandler"
	
	#==== types ====
	const EffectSrc : String = "EffectSrc"
	const FlagUpgradeSrc : String = "FlatUpgradeSrc"
	const ValueUpgradeSrc : String = "ValueUpgradeSrc"
	
	#==== nodes ====
	const Hero : String = "Hero"