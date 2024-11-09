extends HBoxContainer

var hp : int = 5

@export var heart_text : Texture 

func _ready():
	CombatControl.player_heal.connect(heal)
	CombatControl.player_dmg.connect(dmg)
	
func dmg(hp_left):
	for i in range(4, hp_left-1, -1):
		var heart = get_child(i) as TextureRect
		heart.texture = null
	
func heal(hp_left):
	for i in range(0, hp_left):
		var heart = get_child(i) as TextureRect
		heart.texture = heart_text
