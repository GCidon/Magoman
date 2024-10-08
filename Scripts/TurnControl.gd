extends Node

signal turn_end
signal beat(num : int)

signal player_turn_end
signal enemy_turn_end

enum Turn {PLAYER, ENEMY}

var actual_turn : Turn = Turn.PLAYER

func _ready():
	turn_end.connect(next_turn)

func next_turn():
	if actual_turn == Turn.PLAYER:
		actual_turn = Turn.ENEMY
		player_turn_end.emit()
	else:
		actual_turn = Turn.PLAYER
		enemy_turn_end.emit()
		
func reset_turns():
	actual_turn = Turn.PLAYER

func is_player_turn():
	return actual_turn == Turn.PLAYER
	

