class_name Enemy
extends RigidBody2D

var HP : int = 100

@export var imFire : bool = false
@export var imIce : bool = false
@export var imRay : bool = false

@onready var attackTimer : Timer = $AttackTimer
@onready var surroundTimer : Timer = $SurroundTimer

enum State {NONE, SURROUND, ATTACK}

var state : State = State.NONE

func _ready():
	modulate = Color(int(imFire), int(imRay), int(imIce))

func _physics_process(delta):
	match state:
		State.NONE:
			pass
		State.SURROUND:
			surround_state(delta)
		State.ATTACK:
			pass
			
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
	
	var safe : bool = false
		
	if imFire and isFire > 0:
		safe = true
	if imIce and isIce > 0:
		safe = true
	if imRay and isRay > 0:
		safe = true
		
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
		
	found_player()
	
func found_player():
	state = State.SURROUND
	surroundTimer.start()
