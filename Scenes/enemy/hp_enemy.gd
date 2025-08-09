extends TextureButton

var back: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$hp.text = ""
	$animation_hp_card.play("idle")
	if BattleState.can_play_sound:
		$opening.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_hp():
	$Sprite2D.show()
	texture_normal = null
	$hp.text = ""
	back = false
	$animation_hp_card.play_backwards("idle")
	$opening.play()

func _on_animation_hp_card_animation_finished(anim_name):
	if anim_name == "idle":
		if back:
			$Sprite2D.hide()
			$hp.text = str(get_parent().health)
			texture_normal = load("res://assets/operators/herht_card.png")
		else:
			$Timer.wait_time = 0.2
			$Timer.one_shot = true
			$Timer.start()



func _on_timer_timeout():
	if not back:
		$hp.text = str(get_parent().health)
		$animation_hp_card.play("idle")
		back = true
		$opening.play()
