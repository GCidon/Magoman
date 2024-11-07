class_name Player
extends CharacterBody2D

enum Element {MA, GO, MAN, NONE}
var AttackArray : Array[Element] = []

@export var attack_sprite_manager : AttackSpriteManager

@onready var dmg_timer : Timer = $DmgTimer

var hp : int = 5

func _ready():
	TurnControl.player_turn_end.connect(cast_spell)
	TurnControl.enemy_turn_end.connect(reset_spells)
	CombatControl.send_damage.connect(receive_damage)
	CombatControl.enemy_dead.connect(heal)
	
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
	match AttackArray.size():
		3:
			CombatControl.mago_attack.emit(AttackArray[0], AttackArray[1], AttackArray[2])
		2:
			CombatControl.mago_attack.emit(AttackArray[0], AttackArray[1], Element.NONE)
		1:
			CombatControl.mago_attack.emit(AttackArray[0], Element.NONE, Element.NONE)
		0:
			CombatControl.mago_attack.emit(Element.NONE, Element.NONE, Element.NONE)

func receive_damage(dmg):
	if dmg > 0:
		modulate = Color(1, 0, 0)
		dmg_timer.start()
		CombatControl.player_dmg.emit()
		if hp > 1:
			hp -= 1
		else:
			CombatControl.player_dead.emit()
			queue_free()
			
func heal():
	if hp < 5:
		hp += 1

func _on_dmg_timer_timeout():
	modulate = Color(1, 1, 1)
