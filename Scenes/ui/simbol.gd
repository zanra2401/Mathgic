extends TextureRect


var state: String
var anim_used: String = ""
var texture_used: String = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func flip(state):
	texture = null
	self.state = state
	$Sprite2D.show()
	$Sprite2D.texture = load(anim_used)
	if state == "open":
		$simbol_animation.play("flip")
	else:
		$simbol_animation.play_backwards("flip")
	$opening.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_simbol_animation_animation_finished(anim_name):
	if state == "open":
		$Sprite2D.hide()
		texture = load(texture_used)
	else:
		texture = load("res://assets/operators/card_back.png")
		$Sprite2D.hide()
		$ket.text = ""
