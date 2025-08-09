extends TextureButton

var clicked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if not clicked:
		clicked = true
		texture_normal = null
		$anim.show()
		$AnimationPlayer.play_backwards("flip")
		$AudioStreamPlayer.play()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "flip":
		$anim.hide()
		texture_normal = load("res://assets/operators/card_back.png")
		get_tree().current_scene.play()
		if BattleState.event_pertama.prolog:
			get_tree().change_scene_to_file("res://Scenes/ui/prolog.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/world/world_map.tscn")
