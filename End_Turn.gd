extends TextureButton

var active: bool = false
var fliping: bool = false
var turning: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("flip")
	fliping = true
	$Timer.wait_time = 0.47
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if BattleState.battleState == BattleState.BattleState.MY_TURN and not turning:
		$Sprite2D.show()
		texture_normal = null
		$AnimationPlayer.play("flip")
		fliping = true
		$Timer.wait_time = 0.47
		$Timer.start()
		BattleState.deck.generate_card()
		if BattleState.can_play_sound:
			$card_opening.play()
		turning = true


func _on_pressed():
	if active:
		for effect in BattleState.hp.effect_available:
			if BattleState.hp.effect_available[effect].roundLeft > 0:
				BattleState.hp.effect_available[effect].roundLeft -= 1
			
		$Sprite2D.show()
		texture_normal = null
		$AnimationPlayer.play_backwards("flip")
		fliping = true
		$Timer.wait_time = 0.47
		$Timer.start()
		BattleState.deck.fill_placeholder()
		BattleState.battleState = BattleState.BattleState.ENEMY_TURN
		turning = false
		BattleState.spell.reset()
		BattleState.attack.reset()


func _on_timer_timeout():
	if fliping:
		if active:
			texture_normal = load("res://assets/operators/card_back.png")
			active = false
		else:
			active = true
			texture_normal = load("res://assets/operators/end_turn.png")
		fliping = false
		$Sprite2D.hide()
