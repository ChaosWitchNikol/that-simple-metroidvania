extends Node
class_name HeroUtils


enum Variables { MAX_HEALTH, MOVEMENT_SPEED, JUMP_FORCE, ALLOWED_JUMPS, JUMP_DELAY, ALLOW_WALL_CLIMBING }

class VariableNames:
	const HEALTH : String = "health"
	const MAX_HEALTH : String  = "max_health"
	const MOVEMENT_SPEED : String = "movement_speed"
	const JUMP_FORCE : String = "jump_force"
	const ALLOWED_JUMPS : String = "allowed_jumps"
	const JUMP_DELAY : String = "jump_delay"
	const ALLOW_WALL_CLIMBING : String = "allow_wall_climbing"


static func variable2string(variable : int = Variables.MAX_HEALTH) -> String:
	return Variables.keys()[variable]