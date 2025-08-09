extends TextureButton

const ID = "card"

@onready var number: Label = $number
@onready var timer: Timer = $Timer
@onready var animation_sprite: Sprite2D = $animation
@onready var animation_card: AnimationPlayer = $AnimationCard
@onready var card_opening: AudioStreamPlayer2D = $card_opening

@export var value :String = '1000'
@export_enum('add', 'sub', 'mul', 'div', 'attack', 'skill') var type :String = "add"
@export var positif: bool = true
@export var id: String


var dragged: bool = false
var DECK
var inside_spell: bool = false
var inside_attack: bool = false
var inside_enemy: bool = false
var inside_player: bool = false
var animation_state: String = "opening"
var done: bool = false

var inited: bool = false

func setup_card():
	if positif:
		texture_normal = load("res://assets/operators/%s_card.png" % type)
	else:
		texture_normal = load("res://assets/operators/%s_card_n.png" % type)
	number.text = value

func init():
	DECK = get_parent()
	wait_opening()
	
func _process(delta):
	if not inited and BattleState.can_play_sound:
		init()
		inited = true
		
	if dragged:
		var mouse_position = get_global_mouse_position()
		select()
		global_position = Vector2(mouse_position.x - (texture_normal.get_size().x * 0.479 / 2), mouse_position.y - (texture_normal.get_size().y * 0.479 / 2))
	else: 
		unSelect()
		
func _on_button_down():
	if not BattleState.dragging and animation_state == "idle" and not BattleState.battleState in [BattleState.BattleState.LOSE, BattleState.BattleState.WIN]: 
		BattleState.dragging = true
		dragged = true
		z_index = 10
		draw_card_sound(2.10, 2.15)
		
		if get_parent().ID == "Attack_Area":
			BattleState.drag_type = "attack"
		elif get_parent().ID == "Spell_Area":
			BattleState.drag_type = "spell"
			
		reparent(get_tree().current_scene)
		scale = Vector2(0.479, 0.479)



func _unhandled_input(event):
	if dragged and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed:
				z_index = 0
				if (inside_spell or inside_attack) and not id == "ready":
					if BattleState.Player.inti < 1:
						BattleState.status_player.not_enough_inti()
						reparent(DECK)
						dragged = false
						BattleState.dragging = false
						return
					done = true
					BattleState.dragging = false
					BattleState.cards.erase(id)
					BattleState.status_player.use_inti()
					if BattleState.inside_attack:
						BattleState.attack.eval_card({
							"value": value,
							"type": type
						})
						BattleState.attack.eval_selected = false
					else:
						BattleState.spell.eval_card({
							"value": value,
							"type": type
						})
						BattleState.spell.eval_selected = false
						
					dragged = false
					queue_free()
				elif inside_enemy and id == "ready" and BattleState.enemy_selected != null and BattleState.drag_type == "attack":
					var damage_deal: int =  randi() % BattleState.Player.base_damage + 1
					BattleState.enemy_selected.take_damage(BattleState.basic_attack, value, damage_deal)
					BattleState.attack.reset()
					BattleState.drag_type = null
					dragged = false
					BattleState.dragging = false
					queue_free()
				elif inside_player and id == "ready" and BattleState.drag_type == "spell":
					BattleState.spell.reset()
					BattleState.drag_type = null
					dragged = false
					BattleState.dragging = false
					queue_free()
					BattleState.hp.affect(self, load("res://Scenes/attack/heal.tscn").instantiate())
				else:
					reparent(DECK)
					dragged = false
					BattleState.dragging = false


func wait_opening():
	$animation.show()
	
	if positif:
		$animation.texture = load("res://assets/operators/animation/%s_card.png" % type)
	else:
		$animation.texture = load("res://assets/operators/animation/%s_card_n.png" % type)
	
	timer.wait_time = 0.4
	animation_state = "opening"
	animation_card.play("opening")
	
	if type in ["add", "sub", "mul", "div"] and not id == "ready":
		card_opening.volume_db = -15
	else:
		card_opening.volume_db = 1
	card_opening.play()
		
	timer.start()
	
func _on_card_area_entered(area):
	pass # Replace with function body.


func _on_card_area_exited(area):
	pass # Replace with function body.


func _on_timer_timeout():
	if animation_state == "opening":
		animation_sprite.hide()
		animation_state = "idle"
		setup_card()

func select():
	modulate = Color(0.3, 0.3, 0.5)

func unSelect():
	modulate = Color(1, 1, 1)

func draw_card_sound(start_time: float, duration: float):
	$draw_card.play(start_time)
	await get_tree().create_timer(duration).timeout
	$draw_card.stop()
