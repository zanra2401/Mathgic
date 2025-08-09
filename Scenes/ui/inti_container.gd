extends Control

var inti_scene = preload("res://Scenes/ui/inti.tscn")


var enemy_turn: bool = false
@onready var intiContainer: HBoxContainer =  $intiContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	BattleState.status_player = self
	generate_inti()

func use_inti():
	BattleState.Player.inti -= 1
	intiContainer.get_child(BattleState.Player.inti).use_inti()

func not_enough_inti():
	$AnimationPlayer.play("empty")
	
func generate_inti():
	for i in range(BattleState.Player.inti):
		var inti_obj: TextureRect = inti_scene.instantiate()
		intiContainer.add_child(inti_obj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if BattleState.battleState == BattleState.BattleState.MY_TURN and enemy_turn:
		BattleState.Player.inti = 4
		enemy_turn = false
	elif BattleState.battleState == BattleState.BattleState.ENEMY_TURN and not enemy_turn:
		enemy_turn = true
