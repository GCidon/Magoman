extends HBoxContainer

var hp : int = 5

func _ready():
	CombatControl.enemy_dead.connect(heal)
	CombatControl.player_dmg.connect(dmg)
	
func dmg():
	pass
	
func heal():
	pass
