extends TextureButton

var back: bool = true
var effect_available: Dictionary = {
	"defense1": {
		"roundLeft": 0
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	BattleState.hp = self
	$hp.text = ""
	$Sprite2D.show()
	$animation_hp_player.play("opening")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(effect, damage, scale = 1):
	$Sprite2D.show()
	var damage_total: int = damage - BattleState.Player.defense
	if effect_available.defense1.roundLeft > 0:
		damage_total -= 2
		
	if damage_total <= 0:
		BattleState.Player.hp -= 1
	else:
		BattleState.Player.hp -= damage_total
		
	$Sprite2D.modulate = Color(0.6, 0.3, 0.3)
	effect.affected = self
	effect.scale = Vector2(scale, scale)
	$AttackSpot.add_child(effect)

func update_hp():
	$hp.text = ""
	$Sprite2D.show()
	back = false
	texture_normal = null
	$animation_hp_player.play_backwards("opening")
	$opening.play()

func affected_done(name):
	if name == "attacked":
		$Sprite2D.modulate = Color(1, 1, 1)
		update_hp()

func affect(card, effect):
	if int(card.value) == 11:
		if BattleState.Player.hp + 5 > BattleState.Player.max_hp:
			BattleState.Player.hp = BattleState.Player.max_hp
		else:
			BattleState.Player.hp += 5
		get_parent().modulate = Color(1, 1, 1)
		update_hp()
		effect.affected = self
		effect.scale = Vector2(10,10)
		$AttackSpot.add_child(effect)
	elif int(card.value) == 13:
		if effect_available.defense1.roundLeft > 0:
			pass
		else:
			effect_available.defense1.roundLeft = 3
			$animation_hp_player.play("defense")
			


func _on_animation_hp_player_animation_finished(anim_name):
	if anim_name == "opening":
		if back:
			texture_normal = load("res://assets/operators/herht_card.png")
			$Sprite2D.hide()
			$hp.text = str(BattleState.Player.hp)
		else:
			$animation_hp_player.play("opening")
			$opening.play()
			back = true


func _on_area_player_area_entered(area):
	get_parent().modulate = Color(0.3, 0.3, 0.5)
	area.get_parent().inside_player = true


func _on_area_player_area_exited(area):
	get_parent().modulate = Color(1, 1, 1)
	area.get_parent().inside_player = false
