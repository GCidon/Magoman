extends Area2D

func _ready():
	CombatControl.enemy_start_spawn.connect(start_spawn)

func start_spawn(enemyprefab):
	pass
