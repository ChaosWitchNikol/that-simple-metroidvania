extends CTEffect_old
class_name CTAttack_old

# TODO: add animations for the sprite
# TODO: add sounds for the effect

# an arr
export(Array, Resource) var effects : Array = []

# number of affected targets
#	-1 for infinite number of targets
export(int, -1, 1000, 1) var max_targets : int = 1
# speed at which the effect will move
#	0 for effect being non-moveable
export(float) var movement_speed : float
# what area will be affected
export(Shape2D) var area : Shape2D

# how what will be show 
#	in case the it is invissible leave empty
export(Texture) var sprite : Texture