extends Control

const ID: String = "enemy"

@onready var animation_player: AnimationPlayer = $enemy/AnimationPlayer
@onready var text_health: RichTextLabel = $status/health
@onready var health_bar: TextureProgressBar = $status/health_bar
@onready var damage_number: RichTextLabel = $damage
@onready var enemy_sprite: Sprite2D = $enemy

@export var health: int = 15
@export var max_damage: int = 7
@export var defense: int = 1
var number_damage: int = 20
var mouse_inside: bool = false
var turn: int = 0
var next: int = -1
var turning: bool = false
var wait_state: String = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_sprite.modulate = Color(1, 1, 1)
	set_number_damage(20)

func set_number_damage(number):
	number_damage = number
	$damage_card.set_number(number)

func set_health():
	$hp_enemy.update_hp()

func take_damage(attack, number, damage):
	if int(number) == int(number_damage):
		var attack_instan = attack.instantiate()
		attack_instan.affected = self
		$attack_spot.add_child(attack_instan)
		animation_player.play("attacked")
		$enemy.modulate = Color(0.6, 0.3, 0.3)
		$enemy/AnimationPlayer.play("take_damage")
		print("test")
		if damage - defense <= 0:
			health -= 1
		else:
			health -= (damage - defense)
		
		if health < 1:
			health = 0
			$enemy/AnimationPlayer.play("dead")
		
		set_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if turning == false and BattleState.battleState == BattleState.BattleState.ENEMY_TURN and BattleState.enemy_turn == turn:
		turning = true
		wait_state = "wait_attack"
		$Timer.wait_time = 1
		$Timer.one_shot = true
		$Timer.start()

func attack():
	var punch_attack = BattleState.puch.instantiate()
	punch_attack.caller = self
	$enemy/AnimationPlayer.play("attack")
	var deal_damage: int = randi() % max_damage + 1
	BattleState.hp.take_damage(punch_attack, deal_damage, 10)
	

func animation_done(name):
	if name == "attack":
		if not BattleState.battleState in [BattleState.BattleState.LOSE, BattleState.BattleState.LOSE] and next != -1:
			BattleState.enemy_turn = next
		elif not BattleState.battleState in [BattleState.BattleState.LOSE, BattleState.BattleState.LOSE]:
			BattleState.enemy_turn = -1
			BattleState.battleState = BattleState.BattleState.MY_TURN

func _on_area_2d_area_entered(area):
	if area.get_parent().ID == "card":
		var card: TextureButton = area.get_parent()
		card.inside_enemy = true
		BattleState.enemy_selected = self

func _on_area_2d_area_exited(area):
	if area.get_parent().ID == "card":
		var card: TextureButton = area.get_parent()
		card.inside_enemy = false
		BattleState.enemy_selected = null

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attacked":
		animation_player.play("idle")
	elif anim_name == "attack":
		animation_player.play("idle")
	elif anim_name == "take_damage":
		animation_player.play("idle")
	elif anim_name == "dead":
		queue_free()

func _on_timer_timeout():
	if wait_state == "wait_attack":
		attack()
		wait_state = "none"

func affected_done(name_effect):
	if name_effect == "attacked":
		$enemy.modulate = Color(1, 1, 1)

func close_damage():
	$damage_card.close()
