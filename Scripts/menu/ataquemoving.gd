extends TextureRect

@export var spritema : Texture
@export var spritego : Texture
@export var spriteman : Texture

@export var speed : float = 500.0

func _ready():
	var ran = randi_range(0, 2)
	match ran:
		0:
			texture = spritema
		1:
			texture = spritego
		2:
			texture = spriteman
	rotation = randi_range(0, 360)


func _process(delta):
	position.x += speed * delta
	if position.x >= 1500:
		queue_free()
