extends Node2D

var card_scene = preload("res://Scenes/card.tscn")

@onready var enemyes_container: Node2D = $"../Enemys"

@export var padding: float = 6.5
@export var gap: int = 10
@export var scale_card: float = 0.25

var cards: Dictionary = {}

var draged_card: Dictionary =  {"id": null}

var root_node: Node2D

var dragging: bool = false

var mouse_inside: bool = false

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
	root_node = get_tree().get_current_scene()
	generate_card()
	
func set_draged_card(card):
	draged_card = card
	
func summon_drag():
	var card_instance = card_scene.instantiate()
	
	card_instance.type = draged_card.type
	card_instance.value = draged_card.value
	card_instance.id = draged_card.id
	card_instance.global_position = get_global_mouse_position()
	
	add_child(card_instance)

func add_card(card):
	cards[card["id"]] = card

func generate_card():
	for key in range(0, 10):
		var card = {}
		card["type"] = card_type[str(randi() % card_available["add"] + 1)]
		card["value"] = str(randi() % 9 + 1)
		card["id"] = str(key)
		cards[str(key)] = card
	
	for child in enemyes_container.get_children():
		if (child is Node2D):
			var max_card: int = randi() % 5 + 1
			var taken: Array = []
			var number_enemy: int = 0
			for card_i in range(max_card):
				var random_index: int = randi() % 10
				while random_index in taken:
					random_index = randi() % 10
				
				var card_selected: Dictionary = cards[str(random_index)]
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
		

func delete(id):
	cards.erase(id)
	render_deck()

func render_deck():
	for child in get_children():
		child.queue_free()

	var i = 0
	for key in cards:
		var card = cards[key]
		
		var card_instance = card_scene.instantiate()
		card_instance.type = card["type"]
		card_instance.value = card["value"]
		card_instance.id = card["id"]
		
		var card_size: Vector2 = Vector2(card_instance.texture.get_width() * scale_card, card_instance.texture.get_height() * scale_card)
	
		add_child(card_instance)
		
		var col = i % 5
		var row = floor(i / 5)
		
		card_instance.scale = Vector2(scale_card, scale_card)
		card_instance.position = Vector2(
			padding + (card_size.x + gap) * col,
			padding + (card_size.y + gap) * row
		)
		
		i += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
