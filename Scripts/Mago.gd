class_name Player
extends CharacterBody2D

var is_shielding : bool = false
var shield_type : Element = Element.NONE

@onready var shield : Sprite2D = $Shield

enum Element {MA, GO, MAN, NONE}
var AttackArray : Array[Element] = []

@export var attack_sprite_manager : AttackSpriteManager

var hp : int = 3

func _ready():
	TurnControl.player_turn_end.connect(cast_spell)
	TurnControl.enemy_turn_end.connect(reset_spells)
	CombatControl.enemy_attack.connect(receive_damage)
	
func _input(_event):
	if TurnControl.is_player_turn():
		if Input.is_action_just_pressed("shield"):
			shield_up()
		if Input.is_action_just_released("shield"):
			shield_down()
			
		if not is_shielding:
			if Input.is_action_just_pressed("ma"):
				add_spell(Element.MA)
			if Input.is_action_just_pressed("go"):
				add_spell(Element.GO)
			if Input.is_action_just_pressed("man"):
				add_spell(Element.MAN)
		else:
			if Input.is_action_pressed("ma"):
				shield_type = Element.MA
				shield.modulate = Color(1, 0, 0)
			elif Input.is_action_pressed("go"):
				shield_type = Element.GO
				shield.modulate = Color(0, 0, 1)
			elif Input.is_action_pressed("man"):
				shield_type = Element.MAN
				shield.modulate = Color(0, 1, 0)
			else:
				shield_type = Element.NONE
				shield.modulate = Color(1, 1, 1)

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
				
	#animación
	
	CombatControl.mago_attack.emit(ele)

func shield_up():
	is_shielding = true
	shield.visible = true
	
func shield_down():
	is_shielding = false
	shield.visible = false
	shield_type = Element.NONE
	shield.modulate = Color(1, 1, 1)

func receive_damage(ele):
	
	var isFire : int = 0
	var isIce : int = 0
	var isRay : int = 0
	
	while ele.find("MAN") != -1:
		isRay += 1
		ele = ele.erase(ele.find("MAN"), 3)
		
	while ele.find("MA") != -1:
		isFire += 1
		ele = ele.erase(ele.find("MA"), 2)
		
	while ele.find("GO") != -1:
		isIce += 1
		ele = ele.erase(ele.find("GO"), 2)
		
	#Si el tipo del ataque coincide con el escudo, no pasa nada
	if (shield_type == Element.MA and isFire > 0) or (shield_type == Element.GO and isIce > 0) or (shield_type == Element.MAN and isRay > 0):
		pass
	else:
		hp-=1
		if hp<=0:
			queue_free()
		
