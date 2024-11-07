extends TextureRect

var fade : bool = false

func _process(delta):
	if fade:
		modulate.a += 100*delta
		if modulate.a >= 255:
			get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_timer_timeout():
	fade = true
	visible = true
