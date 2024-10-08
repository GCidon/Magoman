class_name Player
extends CharacterBody2D

enum Element {MA, GO, MAN, NONE}
var AttackArray : Array[Element] = []

@export var attack_sprite_manager : AttackSpriteManager

@onready var dmg_timer : Timer = $DmgTimer

var hp : int = 3

func _ready():
	TurnControl.player_turn_end.connect(cast_spell)
	TurnControl.enemy_turn_end.connect(reset_spells)
	CombatControl.send_damage.connect(receive_damage)
	
func _input(_event):
	if TurnControl.is_player_turn():
		if Input.is_action_just_pressed("ma"):
			add_spell(Element.MA)
		if Input.is_action_just_pressed("go"):
			add_spell(Element.GO)
		if Input.is_action_just_pressed("man"):
			add_spell(Element.MAN)

func add_spell(spell : Element):
	if AttackArray.size() < 3:
		AttackArray.append(spell)
		var numspell : int = int(spell)
		attack_sprite_manager.set_attack(AttackArray.size(), numspell)
		
func reset_spells():
	AttackArray.clear()
		
func cast_spell():
	var ele : String = ""
	for i in AttackArray:
		match i:
			Element.MA:
				ele += "MA"
			Element.GO:
				ele += "GO"
			Element.MAN:
				ele += "MAN"
	
	CombatControl.mago_attack.emit(AttackArray[0], AttackArray[1], AttackArray[2])

func receive_damage(dmg):
	if dmg > 0:
		modulate = Color(1, 0, 0)
		dmg_timer.start()

func _on_dmg_timer_timeout():
	modulate = Color(1, 1, 1)
