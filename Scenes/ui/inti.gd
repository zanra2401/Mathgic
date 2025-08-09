extends TextureRect

var active: bool = false
var enemy_turn: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.show()
	texture = null
	$AnimationPlayer.play_backwards("flip")

func use_inti():
	texture = null
	$Sprite2D.show()
	$AnimationPlayer.play("flip")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if BattleState.battleState == BattleState.BattleState.MY_TURN and enemy_turn:
		if not active:
			$Sprite2D.show()
			texture = null
			$AnimationPlayer.play_backwards("flip")
		enemy_turn = false
	elif BattleState.battleState == BattleState.BattleState.ENEMY_TURN and not enemy_turn:
		enemy_turn = true

func _on_animation_player_animation_finished(anim_name):
	if active:
		texture = load("res://assets/UI2/card_outline.png")
		active = false
		$Sprite2D.hide()
	else:
		texture = load("res://assets/UI2/card.png")
		$Sprite2D.hide()
		active = true
