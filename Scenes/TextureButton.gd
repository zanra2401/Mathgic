extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_pressed():
	modulate = Color(0.2, 0.2, 0.2)


func _on_button_up():
	modulate = Color(1, 1, 1)


func _on_button_down():
	modulate = Color(0.8, 0.8, 0.8)
