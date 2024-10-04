extends ProgressBar

@export var turn_duration : float = 2.0

func _ready():
	max_value = turn_duration

func _process(delta):
	value += 1 * delta
	if value >= turn_duration:
		value = 0
		TurnControl.turn_end.emit()
