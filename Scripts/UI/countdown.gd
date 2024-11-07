extends Label

@onready var realtimer : Timer = $RealTimer
@onready var starttimer : Timer = $StartTimer

var count : int = 3

func _ready():
	CombatControl.enemy_dead.connect(reset)

func _on_start_timer_timeout():
	realtimer.start()
	starttimer.stop()
	visible = true

func _on_real_timer_timeout():
	if count > 1:
		count -= 1
		text = str(count)
	elif not text == "GO":
		text = "GO"
	else:
		CombatControl.start_game.emit()
		visible = false
		stop()
		
func stop():
	realtimer.stop()
		
func reset():
	visible = true
	count = 3
	text = str(count)
	realtimer.start()
		
