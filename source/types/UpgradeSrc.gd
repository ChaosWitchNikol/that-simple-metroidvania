extends Resource
class_name UpgradeSrc



export(HeroUtils.Variables) var variable_name : int = HeroUtils.Variables.MAX_HEALTH
export(float, -4096, 4096, 0.01) var amount : float = 0
export(int, 0, 16384) var size : int = 64