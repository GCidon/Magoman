class_name Enemy
extends RigidBody2D

var HP : int = 100

@export var imFire : bool = false
@export var imIce : bool = false
@export var imRay : bool = false

@export var attack_manager : EnemyAttackManager

@onready var attackTimer : Timer = $AttackTimer
@onready var surroundTimer : Timer = $SurroundTimer

enum State {NONE, SURROUND, ATTACK}
enum Elements {FIRE, ICE, RAY}

var state : State = State.NONE

var attacks : Array[Elements]

func _ready():
	modulate = Color(int(imFire), int(imRay), int(imIce))
	TurnControl.player_turn_end.connect(start_turn)
	TurnControl.beat.connect(on_beat)
	CombatControl.mago_attack.connect(take_damage)
	
func start_turn():
	state = State.SURROUND
	surroundTimer.start()

func _process(delta):
	match state:
		State.NONE:
			pass
		State.SURROUND:
			surround_state(delta)
		State.ATTACK:
			attack_state(delta)
			
func surround_state(_delta):
	pass
	
func attack_state(_delta):
	pass

func take_damage(bulelement : String):
	var isFire : int = 0
	var isIce : int = 0
	var isRay : int = 0
	 
	while bulelement.find("MAN") != -1:
		isRay += 1
		bulelement = bulelement.erase(bulelement.find("MAN"), 3)
		
	while bulelement.find("MA") != -1:
		isFire += 1
		bulelement = bulelement.erase(bulelement.find("MA"), 2)
		
	while bulelement.find("GO") != -1:
		isIce += 1
		bulelement = bulelement.erase(bulelement.find("GO"), 2)
	
	var safe : bool = true
		
	if imFire and isFire >= 0:
		safe = true
	elif imIce and isIce >= 0:
		safe = true
	elif imRay and isRay >= 0:
		safe = true
	else:
		safe = false
		
	if not safe:
		
		queue_free()

func _on_surround_timer_timeout():
	state = State.ATTACK
	attackTimer.start()

func _on_attack_timer_timeout():
	var ele : String = ""
		
	if imFire:
		ele += "MA"
	if imIce:
		ele += "GO"
	if imRay:
		ele += "MAN"
	
	CombatControl.enemy_attack.emit(ele)
	
func on_beat(num):
	if state == State.SURROUND:
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
