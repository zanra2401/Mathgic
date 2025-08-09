extends TextureButton

var clicked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_anim():
	self.show()
	texture_normal = null
	$card.frame = 8
	$card.show()
	texture_normal = null
	$car_play_anim.play("show")

func hide_anim():
	$card.show()
	texture_normal = null
	$car_play_anim.play("hide")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_car_play_anim_animation_finished(anim_name):
	if anim_name == "show":
		$card.hide()
		texture_normal = load("res://assets/operators/start_level_card.png")
		$car_play_anim.play("idle")
		
	if anim_name == "hide":
		$card.hide()
		self.hide()
	
	if anim_name == "flip":
		get_tree().current_scene.close_world()


func _on_pressed():
	if not clicked:
		clicked = true
		texture_normal = null
		$card.show()
		get_tree().current_scene.destination_scene = "level"
		$click.play()
		$car_play_anim.play_backwards("flip")
