extends Resource
class_name ResEnemy

#==== life ====
export(bool) var is_passive : bool = false
export(float, 0, 1024) var mass : float = 100
export(float, 0, 1000, 10) var movement_speed : float = 400
#==== body ====
export(Resource) var body : Resource # ResTransformShape2D
#==== view ====
export(Resource) var view : Resource # ResTransformShape2D
#==== sprite ====
export(Resource) var sprite : Resource # ResAnimationSprite
#==== animations ====
export(Resource) var animations : Resource # ResAnimationsEnemy
#==== attack ====
export(Resource) var attack_range : Resource # ResTransformShape2D
export(Resource) var attack : Resource # ResAttack
