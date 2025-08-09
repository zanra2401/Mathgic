extends TextureButton

var active: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	$card.show()
	texture_normal = null
	$card_anim.play("flip")
	if BattleState.can_play_sound:
		$flip.play()

func _on_pressed():
	if active:
		if get_tree().current_scene.stage + 1 < get_tree().current_scene.total_stage:
			get_tree().current_scene.get_random_event()
			$card.show()
			texture_normal = null
			$card_anim.play_backwards("flip")
			$flip.play()
		else:
			$"../..".hide()
			
		get_tree().current_scene.set_destination(1500)

func _on_card_anim_animation_finished(anim_name):
	if anim_name == "flip" and active:
		$card.hide()
		texture_normal = load("res://assets/operators/card_back.png")
		active = false
	else:
		$card.hide()
		texture_normal = load("res://assets/operators/next_stage_card.png")
		active = true
