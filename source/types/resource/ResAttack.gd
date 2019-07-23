extends ResEffect_old
class_name ResAttack_old

# array of aditional effects
export(Array, Resource) var effects : Array = [] # ResEffect
# number of affected targets
#	-1 for infinite number of targets
export(int, -1, 1024) var max_targets : int = 1
# speed at which the effect will move
#	0 for effect being non-moveable
export(float) var movement_speed : float = 0
# what area will be affected
export(Shape2D) var area : Shape2D
# how what will be show 
#	in case the it is invisible leave empty
export(Texture) var sprite : Texture
