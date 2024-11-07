extends ProgressBar

var turn_duration : float = 0.0
var beat_duration : float = 0.0
var beat_counter : float = 0.0

@export var bpms : int = 0

var paused : bool = true

var actual_beat : int = 0

func _ready():
	max_value = 100
	var bpss : float = bpms/60.0
	turn_duration = 4.0/bpss
	beat_duration = 1.0/bpss
	CombatControl.start_game.connect(resume)
	CombatControl.enemy_dead.connect(stop)

func _process(delta):
	if not paused:
		beat_counter+=delta
		
		if beat_counter >= beat_duration:
			beat_counter = 0.0
			actual_beat += 1
			if actual_beat == 4:
				actual_beat = 0
			TurnControl.beat.emit(actual_beat)
			
		value += (100.0/turn_duration) * delta
		if value >= max_value:
			value = 0
			TurnControl.turn_end.emit()
		
func stop():
	value = 0
	paused = true
	
func resume():
	paused = false
	if bpms < 400:
		bpms += 20
		var bpss : float = bpms/60.0
		turn_duration = 4.0/bpss
		beat_duration = 1.0/bpss
