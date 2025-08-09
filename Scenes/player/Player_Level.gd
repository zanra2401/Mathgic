extends Node2D

enum state {WALK, IDLE, RUN, CUTSCENE}

const WALK_SPEED: Vector2 = Vector2(5, 0)
const RUN_SPEED: Vector2 = Vector2(15, 0)
var sampai: bool = false

var state_player = state.IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position.x = BattleState.level_stage["last_position"]
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state_player == state.IDLE:
		animation_select("idle")
	elif state_player == state.RUN:
		animation_select("run")
	elif state_player == state.WALK:
		animation_select("walk")
	
	if global_position.x < get_tree().current_scene.destination:
		global_position += WALK_SPEED
		state_player = state.WALK
	
	if global_position.x == get_tree().current_scene.destination and not sampai:
		state_player = state.IDLE
		sampai = true
		get_tree().current_scene.sampai()
	
	if state_player == state.RUN:
		global_position += RUN_SPEED
	
func animation_select(anim):
	for child in get_children():
		if child.name != anim and child.name in ["idle", "run", "walk"]:
			child.hide()
		elif child.name in ["idle", "run", "walk"]:
			child.show()

func play_cutscene(anim_name):
	state_player = state.CUTSCENE
	$cutscene.show()
	$idle.hide()
	$run.hide()
	$walk.hide()
	$cutscene.play_anim(anim_name)

func cutscene_done(anim_name):
	get_parent().cutscene_done(anim_name)
	$cutscene.hide()
	if anim_name == "penasaran":
		$idle.show()
		state_player = state.IDLE

func _input(event):
	pass
