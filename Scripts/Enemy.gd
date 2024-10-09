class_name Enemy
extends RigidBody2D

@export var attack_manager : EnemyAttackManager

enum State {NONE, SURROUND}
enum Elements {FIRE, ICE, RAY}

var state : State = State.SURROUND

var attacks : Array[Elements]

func _ready():
	TurnControl.player_turn_end.connect(start_turn)
	TurnControl.enemy_turn_end.connect(end_turn)
	TurnControl.beat.connect(on_beat)
	
func start_turn():
	state = State.SURROUND
	attacks.clear()
	
func end_turn():
	state = State.NONE
	CombatControl.enemy_attack.emit(attacks[0], attacks[1], attacks[2])
	
func on_beat(num):
	if state == State.SURROUND:
		if attacks.size() < 3:
			add_attack()
		
func add_attack():
	var ele : Elements
	var randomele = randi_range(0, 2)
	match randomele:
		0:
			ele = Elements.FIRE
		1:
			ele = Elements.ICE
		2:
			ele = Elements.RAY
	attacks.append(ele)
	attack_manager.set_attack(attacks.size(), randomele)
