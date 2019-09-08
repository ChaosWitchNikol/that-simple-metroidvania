extends Resource
class_name EffectSrc


export(String, "health", "movenemt_speed") var variable : String = "health"
export(float, -9999, 9999, 0.5) var value : float = 0
export(float, 0, 4096, 0.01) var duration : float = 0
export(bool) var target_self : bool = false 