extends Object
class_name C

const TILE_SIZE : int = 32
const TILE_SIZEF : float = TILE_SIZE * 1.0
const HALF_TILE_SIZE : int = TILE_SIZE / 2
const HALF_TILE_SIZEF : float = TILE_SIZEF / 2.0
const Q_TILE_SIZE : int = TILE_SIZE / 4
const Q_TILE_SIZEF : float = TILE_SIZEF / 4.0

const GRAVITY_VALUE : float = 9.8
const GRAVITY_VECTOR : Vector2 = Vector2(0, 1)
enum GRAVITY_DIRECTION { DOWN = 0, LEFT = 1, UP = 2, RIGHT = 3, NONE = 4}
const GRAVITY_VECTOR_SET = [Vector2.DOWN, Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.ZERO]

const FLOOR_VECTOR : Vector2 = Vector2(0, -1)

const SNAP_VECTOR : Vector2 = Vector2(0, 24)
const JUMP_SNAP_VECTOR : Vector2 = Vector2(0, 0)

enum FACING { RIGHT=1, LEFT=-1, NONE=0 }

