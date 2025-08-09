extends PanelContainer

var card_scene = preload("res://Scenes/card.tscn")
var placeholder = preload("res://Scenes/card_placeholder.tscn")

@onready var DeckGrid: GridContainer = $MarginContainer/DeckGrid

var card_available: Dictionary = {
	"add": 1,
	"sub": 2,
	"mul": 3,
	"div": 4
}

var card_type = {
	"1": "add",
	"2": "sub",
	"3": "mul",
	"4": "div"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	BattleState.deck = self

func generate_card():
	for key in range(0, 10):
		var card = {}
		card["type"] = card_type[str(randi() % card_available["add"] + 1)]
		card["value"] = str(randi() % 5 + 5)
		card["id"] = str(key)
		card["positif"] = false
		BattleState.cards[str(key)] = card
	
	for child in BattleState.enemies.get_children():
		var max_card: int = randi() % 3 + 1
		var taken: Array = []
		var number_enemy: int = 0
		for card_i in range(max_card):
			var random_index: int = randi() % 10
			while random_index in taken:
				random_index = randi() % 10
			
			var card_selected: Dictionary = BattleState.cards[str(random_index)]
			
			match card_selected.type:
				"add":
					number_enemy += int(card_selected.value)
				"sub":
					number_enemy -= int(card_selected.value)
				"mul":
					number_enemy *= int(card_selected.value)
				"div": 
					number_enemy /= int(card_selected.value)
			
			taken.push_back(random_index)
		child.set_number_damage(number_enemy)
		
			
	render_deck()

func fill_placeholder():
	for child in DeckGrid.get_children():
		child.queue_free()
	
	for i in range(0, 10):
		DeckGrid.add_child(placeholder.instantiate())
	
func render_deck():
	for child in DeckGrid.get_children():
		child.queue_free()
		
	for key in BattleState.cards:
		var card = card_scene.instantiate()
		card.id = BattleState.cards[str(key)].id
		card.type = BattleState.cards[str(key)].type
		card.value = BattleState.cards[str(key)].value
		DeckGrid.add_child(card)
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
