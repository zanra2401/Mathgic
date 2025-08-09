extends TextureButton

@export var positif = true 
var active = false
var turning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_normal = null
	$Sprite2D.show()
	$animation_card.play("opening")
	if BattleState.can_play_sound:
		$opening.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if BattleState.battleState == BattleState.BattleState.ENEMY_TURN and not turning:
		close()
		turning = true
	
func close():
	if active:
		texture_normal = null
		$Sprite2D.show()
		$number.text = ""
		$animation_card.play_backwards("opening")
		$opening.play()

func open():
	if not active:
		texture_normal = null
		$Sprite2D.show()
		$number.text = ""
		$animation_card.play("opening")
		$opening.play()

func set_number(number):
	$number.text = str(number)
	turning = false
	open()

func _on_animation_card_animation_finished(anim_name):
	if anim_name == "opening":
		if active:
			texture_normal = load("res://assets/operators/card_back.png")
			$Sprite2D.hide()
			active = false
		else:
			texture_normal = load("res://assets/operators/attack_card.png")
			$number.text = str(get_parent().number_damage)
			$Sprite2D.hide()
			active = true
