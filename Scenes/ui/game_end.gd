extends Node2D
var animation_name: String = ""
var jeda: String = ""
var win_level: bool = false
var temp_pengalaman: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	BattleState.transition = self
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_end_animation_animation_finished(anim_name):
	$simbol.texture = load("res://assets/operators/card_back.png")
	
	if anim_name == "end" and animation_name == "win_battle":
		$Timer.wait_time = 0.5
		$Timer.one_shot = true
		$Timer.start()
	elif anim_name == "end" and animation_name == "open_world":
		get_tree().current_scene.transition_done("open_world")
		BattleState.can_play_sound = true
	elif anim_name == "end" and animation_name == "close_world":
		get_tree().current_scene.transition_done("close_world")

func transition_open_world():
	BattleState.can_play_sound = false
	$Timer.wait_time = 0.5
	$Timer.one_shot = true
	$Timer.start()
	jeda = "open_jeda"

func transition_open_world_f():
	BattleState.can_play_sound = false
	$simbol.texture_used = "res://assets/operators/start_level_card.png"
	$simbol.anim_used = "res://assets/operators/animation/start_level_card.png"
	$simbol.flip("open")
	$Timer.wait_time = 1
	$Timer.one_shot = true
	$Timer.start()
	animation_name = "open_world"

func transition_close_world():
	BattleState.can_play_sound = false
	$end_animation.play("end")
	$Timer.wait_time = 2
	$Timer.one_shot = true
	$Timer.start()
	animation_name = "close_world"
	
func transition_win_battle():
	BattleState.can_play_sound = false
	$end_animation.play("end")
	$Timer.wait_time = 2
	$Timer.one_shot = true
	$Timer.start()
	animation_name = "win_battle"

func transition_lose_battle():
	BattleState.can_play_sound = false
	$end_animation.play("end")
	$Timer.wait_time = 2
	$Timer.one_shot = true
	$Timer.start()
	animation_name = "lose_battle"

func end_combat(state):
	if state == "win":
		if not win_level:
			BattleState.pengalaman_colected += temp_pengalaman
			
		temp_pengalaman = 0
		transition_win_battle()
	else:
		$defeat.play()
		transition_lose_battle()

func _on_timer_timeout():
	if jeda == "open_jeda":
		transition_open_world_f()
		jeda = ""
		return

	if animation_name == "open_world":
		$end_animation.play_backwards("end")
		
	if animation_name == "win_battle":
		$simbol.texture_used = "res://assets/operators/win_card.png"
		$simbol.anim_used = "res://assets/operators/animation/win_card.png"
		$end_battle.show()
		$simbol.flip("open")
		
	if animation_name == "lose_battle":
		$simbol.texture_used = "res://assets/operators/defeat_card.png"
		$simbol.anim_used = "res://assets/operators/animation/defeat_card.png"
		$end_battle.show()
		$end_battle/reward.hide()
		$simbol.flip("open")

func close_simbol():
	if animation_name == "lose_battle":
		$simbol.texture_used = "res://assets/operators/defeat_card.png"
		$simbol.anim_used = "res://assets/operators/animation/defeat_card.png"
		$simbol.flip("close")
	elif animation_name == "win_battle":
		$simbol.texture_used = "res://assets/operators/win_card.png"
		$simbol.anim_used = "res://assets/operators/animation/win_card.png"
		$simbol.flip("close")

func set_reward():
	$end_battle/reward/Label.text = str(BattleState.pengalaman_colected)
	
