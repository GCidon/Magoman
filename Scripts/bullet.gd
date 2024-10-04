class_name Bullet
extends Area2D

var dir : Vector2

var speed : float = 200.0

var element : String = ""

var fromPlayer : bool = false

func set_bullet(ele : String, player : bool):
	element = ele
	parse_element()
	fromPlayer = player
	
func parse_element():
	var isFire : int = 0
	var isIce : int = 0
	var isRay : int = 0
	
	var ele = element
	
	while ele.find("MAN") != -1:
		isRay += 1
		ele = ele.erase(ele.find("MAN"), 3)
		
	while ele.find("MA") != -1:
		isFire += 1
		ele = ele.erase(ele.find("MA"), 2)
		
	while ele.find("GO") != -1:
		isIce += 1
		ele = ele.erase(ele.find("GO"), 2)
		
	modulate = Color(isFire/3.0, isRay/3.0, isIce/3.0)
	
	speed = isRay*125 + isFire*50 + isIce*25

func _physics_process(delta):
	position += dir * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is Enemy:
		var enemy = body as Enemy
		enemy.take_damage(element)
		queue_free()
	if body is Player and not fromPlayer:
		var player = body as Player
		player.receive_bullet(element)
		queue_free()
