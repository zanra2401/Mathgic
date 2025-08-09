extends Sprite2D

@onready var number: Label = $number
@onready var enemyes_container: Node2D = $Enemys

@export var value :String = '1'
@export_enum('add', 'sub', 'mul', 'div') var type :String = "add"
@export var id: String



var mode_static: bool = false

func setup_card():
	self.texture = load("res://assets/operators/%s.png" % type)	
	number.text = value

func _ready():
	setup_card()
	$Area2D.input_event.connect(_on_area_input_event)

func _process(delta):
	#print(get_parent().draged_card.id)
	if not mode_static:
		if get_parent().dragging and get_parent().draged_card.id == id:
			global_position = get_global_mouse_position()
	else:
		if get_parent().dragging:
			global_position = get_global_mouse_position()

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and not mode_static:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				get_parent().set_draged_card({
					"type": type,
					"value": value,
					"id": id
				})
				get_parent().dragging = true
				get_parent().delete(id)
				get_parent().summon_drag()
			elif get_parent().draged_card.id == id:
				get_parent().dragging = false
				if get_tree().get_current_scene().get_child(1).mouse_inside == false:
					get_parent().add_card({
						"type": type,
						"value": value,
						"id": id
					})
				else:
					get_tree().get_current_scene().get_child(1).eval(get_parent().draged_card)
					
				get_parent().draged_card = {"id": null}
				self.queue_free()
				
				get_parent().render_deck()
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				queue_free()
				get_parent().dragging = true
				get_parent().summon_drag()
			else:
				var inside_enemy: bool = false
				get_parent().dragging = false
				for child in get_tree().get_current_scene().get_child(0).get_children():
					if (child is Node2D):
						if child.mouse_inside:
							inside_enemy = true
							break
				if inside_enemy:
					self.queue_free()
					get_parent().reset()
				else:
					get_parent().render_card()
				self.queue_free()
		



