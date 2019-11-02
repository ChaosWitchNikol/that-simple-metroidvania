extends Node
class_name WUBsUtils


enum Variables { MAX_HEALTH, MOVEMENT_SPEED, JUMP_FORCE, ALLOWED_JUMPS, JUMP_DELAY }
enum Flags { ALLOW_WALL_CLIMBING }
enum Weapons { BOLTER }




static func variable2str(variable : int = Variables.MAX_HEALTH) -> String:
	return Variables.keys()[variable]


static func flag2str(flag : int = Flags.ALLOW_WALL_CLIMBING) -> String:
	return Flags.keys()[flag]


static func weapon2str(weapon : int = Weapons.BOLTER) -> String:
	return Weapons.keys()[weapon]