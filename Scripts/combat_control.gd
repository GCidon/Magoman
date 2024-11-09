extends Node

signal mago_attack(at1, at2, at3)
signal enemy_attack(at1, at2, at3)
signal send_damage(dmg)
signal enemy_dead()
signal enemy_start_spawn(prefab)
signal enemy_spawned()
signal start_game()

signal player_dmg(hp_left)
signal player_heal(hp_left)

signal player_dead()

var enemy_attacks : Array[int]

func _ready():
	enemy_attack.connect(add_enemy_attack)
	mago_attack.connect(check_mago_attack)
	
func add_enemy_attack(at1, at2, at3):
	enemy_attacks.append(at1)
	enemy_attacks.append(at2)
	enemy_attacks.append(at3)
	
func check_mago_attack(at1, at2, at3):
	var dmg : int = 0
	
	if at1 != enemy_attacks[0]:
		dmg += 1
	if at2 != enemy_attacks[1]:
		dmg += 1
	if at3 != enemy_attacks[2]:
		dmg += 1

	send_damage.emit(dmg)
	enemy_attacks.clear()
