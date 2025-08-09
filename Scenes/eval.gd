extends Node2D

var mouse_inside: bool = false

var card_scene = preload("res://Scenes/card.tscn")
var total: int = 0
var dragging: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	eval({"type": "add", "value": "0", "id": "ready"})

func reset():
	total = 0
	eval({"type": "add", "value": "0", "id": "ready"})
	render_card()

func summon_drag():
	var card_instance = card_scene.instantiate()
	
	card_instance.type = "add"
	card_instance.value = str(total)
	card_instance.id = "ready"
	card_instance.mode_static = true
	
	card_instance.global_position = get_global_mouse_position()
	
	add_child(card_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func eval(card):
	for child in get_children():
		if not (child is Area2D):
			child.queue_free()
			
	if card.type == "add":
		total += int(card.value)
	elif card.type == "sub":
		total -= int(card.value)
	elif card.type == "mul":
		total *= int(card.value)
	elif card.type == "div":
		total /= int(card.value)
	
	render_card()

func render_card():
	var card_instance = card_scene.instantiate()
	
	card_instance.type = "add"
	card_instance.value = str(total)
	card_instance.id = "ready"

	card_instance.position = Vector2(0, 0)
	card_instance.mode_static = true
	
	add_child(card_instance)

func _on_area_2d_mouse_entered():
	mouse_inside = true

func _on_area_2d_mouse_exited():
	mouse_inside = false
