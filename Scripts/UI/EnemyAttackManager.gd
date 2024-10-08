class_name EnemyAttackManager
extends VBoxContainer

@onready var attack1 : TextureRect = $TextureRect1
@onready var attack2 : TextureRect = $TextureRect2
@onready var attack3 : TextureRect = $TextureRect3

@export var sprite_ma : Texture
@export var sprite_go : Texture
@export var sprite_man : Texture

var attack_array : Array[TextureRect] = [null, null, null]
var sprite_array : Array[Texture] = [null, null, null]

func _ready():
	attack_array[0] = attack1
	attack_array[1] = attack2
	attack_array[2] = attack3
	
	sprite_array[0] = sprite_ma
	sprite_array[1] = sprite_go
	sprite_array[2] = sprite_man
	
	TurnControl.player_turn_end.connect(reset)

func set_attack(num_attack : int, attack : int):
	attack_array[num_attack-1].texture = sprite_array[attack]

func reset():
	attack_array[0].texture = null
	attack_array[1].texture = null
	attack_array[2].texture = null
