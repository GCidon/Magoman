extends Control

@export var atack : PackedScene

@onready var spawnerTimer : Timer = $Timer


func _on_timer_timeout():
	var ran = randi_range(0, 400)
	var at = atack.instantiate() as TextureRect
	add_child(at)
	at.position.x = 0
	at.position.y = ran
