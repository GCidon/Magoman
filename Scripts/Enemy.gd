class_name Enemy
extends RigidBody2D

var HP : int = 100

@export var imFire : bool = false
@export var imIce : bool = false
@export var imRay : bool = false

@export var bullet : PackedScene

@onready var attackTimer : Timer = $AttackTimer
@onready var surroundTimer : Timer = $SurroundTimer
@onready var moveRaycast : RayCast2D = $RayCast2D

enum State {NONE, SURROUND, ATTACK}

var state : State = State.NONE

var player : Player = null

var fleeDir : Vector2
var moveDir : Vector2
var speed : float = 100.0

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
			
func surround_state(delta):
	fleeDir = (position - player.position).normalized()
	moveDir = (position - player.position).normalized()
	moveRaycast.target_position = fleeDir * 200
	if moveRaycast.is_colliding():
		var colVector : Vector2 = moveRaycast.target_position.normalized()
		var perpen = colVector.orthogonal()
		moveDir = fleeDir + perpen
	position += moveDir * speed * delta
	
func attack_state(delta):
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
		


func _on_rango_body_entered(body):
	if body is Player:
		player = body as Player
	found_player()

func _on_rango_body_exited(body):
	if body is Player:
		player = null
	state = State.NONE

func _on_surround_timer_timeout():
	state = State.ATTACK
	attackTimer.start()

func _on_attack_timer_timeout():
	if player != null:
		var newbullet = bullet.instantiate() as Bullet
		newbullet.global_position = global_position
		owner.add_child(newbullet)
		
		var dir : Vector2 = (player.position - position).normalized()
		newbullet.dir = dir
		var ele : String = ""
		
		if imFire:
			ele += "MA"
		if imIce:
			ele += "GO"
		if imRay:
			ele += "MAN"
					
		newbullet.set_bullet(ele, false)	
		found_player()
	else:
		state = State.NONE
	
func found_player():
	state = State.SURROUND
	fleeDir = (position - player.position).normalized()
	moveRaycast.target_position = fleeDir * 200
	surroundTimer.start()
