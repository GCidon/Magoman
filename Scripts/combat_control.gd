extends Node

signal mago_attack(element)
signal enemy_attack(element)
signal enemy_dead()
signal enemy_start_spawn(prefab)
signal enemy_spawned()

@export var enemy_prefab : PackedScene

func _ready():
	enemy_dead.connect(spawn_enemy)

func spawn_enemy():
	enemy_start_spawn.emit(enemy_prefab)
