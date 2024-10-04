extends Label

func _ready():
	TurnControl.player_turn_end.connect(player_end)
	TurnControl.enemy_turn_end.connect(enemy_end)
	
func player_end():
	text = "TURNO DE ENEMIGO"
	
func enemy_end():
	text = "TURNO DE MAGOMAN"
