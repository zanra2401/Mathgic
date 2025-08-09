extends MarginContainer

@export var ID: String

@onready var base_card: TextureButton = $Card

var card_scene = preload("res://Scenes/card.tscn")
var total: int = 0
var card_instance = null

var eval_selected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if ID == "Attack_Area":
		BattleState.attack = self
	else:
		BattleState.spell = self
		
	eval_card({"type": "skill", "value": "0", "id": "ready"})

func reset():
	total = 0
	eval_card({"type": "skill", "value": "0", "id": "ready"})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if card_instance != null:
		if eval_selected:
			select()
		else:
			unSelect()

func select():
	modulate = Color(0.3, 0.3, 0.5)

func unSelect():
	modulate = Color(1, 1, 1)

func eval_card(card):
	if card.type == "add":
		total += int(card.value)
	elif card.type == "sub":
		total -= int(card.value)
	elif card.type == "mul":
		total *= int(card.value)
	elif card.type == "div":
		total /= int(card.value)
	
	delete_card()
	render_card()
	unSelect()
	
func delete_card():
	for child in get_children():
		if child.ID == "card":
			child.queue_free()

func render_card():
	card_instance = card_scene.instantiate()
	if total < 0:
		card_instance.positif = false
	else:
		card_instance.positif = true
	if ID == "Attack_Area":
		card_instance.type = "attack"
	else:
		card_instance.type = "skill"
		
	card_instance.value = str(total)
	card_instance.id = "ready"
	add_child(card_instance)
