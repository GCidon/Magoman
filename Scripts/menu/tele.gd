extends TextureRect

@onready var timer : Timer = $Timer

var zoomin : bool = false

func _process(delta):
	if zoomin:
		scale.x += 0.5 * delta
		scale.y += 0.5 * delta

func _on_button_pressed():
	zoomin = true
	timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
