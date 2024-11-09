extends TextureRect

func _ready():
	CombatControl.player_dead.connect(appear)
	
func appear():
	visible = true

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
