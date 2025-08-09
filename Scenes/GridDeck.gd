extends GridContainer

var card: = preload("res://Scenes/card.tscn")

@export var gap: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 8):
		var card_instance = card.instantiate()
		card_instance.type = "add"
		card_instance.value = "9"
		
		self.add_child(card_instance)

func generateCard():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
