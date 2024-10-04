extends Sprite2D

@export var angle : float = 10.0
@export var step : int = 30
var dir : int = 1

func _process(delta):
	rotation_degrees += dir * delta * step
	if abs(rotation_degrees) > abs(angle):
		dir *= -1
