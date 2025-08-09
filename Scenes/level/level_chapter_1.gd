extends Node2D

var destination: float = -100
var level: int = 1
var stage: int = 0
var event: String = ""
@export var total_stage: int = 20
var done: bool = false

@onready var transisi: Node2D = $Transisi_Layer/Transisi

# Called when the node enters the scene tree for the first time.
func _ready():
	set_pengalaman()
	stage = BattleState.level_stage["stage"]
	$Transisi_Layer/Transisi.transition_open_world()

func set_pengalaman():
	$CanvasLayer/Node2D/Pengalaman.text = str(BattleState.pengalaman_colected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stage == total_stage and not done:
		transisi.win_level = true
		transisi.end_combat("win")
		transisi.set_reward()
		BattleState.win_level()
		$Player/music.stop()
		$win.play()
		done = true
		

func get_random_event():
	if stage in BattleState.levels[level]["uniq_event"]:
		if BattleState.levels[level][stage] == "run":
			event = "run"
	else:
		var random_number: int = randi_range(1, 100)
		if random_number <= 80:
			event = "battle"
		else:
			event = "memories_puzzle"

func set_destination(range):
	destination = $Player.global_position.x + range
	$Player.animation_select("walk")
	$Player.sampai = false

func start_run_minigame():
	$run.start()
	$CanvasLayer.hide()
	$Player.state_player = $Player.state.RUN

func sampai(): 
	stage += 1
	if stage < total_stage:
		BattleState.level_stage.stage = stage
		BattleState.level_stage.last_position = global_position.x
		if event == "battle":
			$Player/music.stop()
			$Transisi_Layer/Transisi.transition_close_world()
		elif event == "run":
			$Player/idle.hide()
			$Player/run.hide()
			stop_music()
			$Player.play_cutscene("kaget_lari")
		elif event == "memories_puzzle":
			$Player/idle.hide()
			$Player/run.hide()
			$Player.play_cutscene("penasaran")
		else:
			$CanvasLayer/HBoxContainer/next.activate()

func stop_music():
	$di_kejar.stop()
	$Player/music.stop()

func start_music():
	$Player/music.play()

func transition_done(transisi):
	if transisi == "open_world":
		$Player/music.play()
	elif transisi == "close_world":
		$Timer.wait_time = 0.5
		$Timer.one_shot = true
		$Timer.start()

func _on_music_finished():
	$Player/music.play()

func proses_battle():
	get_tree().change_scene_to_file("res://Scenes/combat.tscn")


func _on_timer_timeout():
	if event == "battle":
		proses_battle()
	elif event == "memories_puzzle":
		pass
	elif event == "run_done":
		$Player.state_player = $Player.state.IDLE
		destination = $Player.global_position.x
		sampai()
		start_music()
		$CanvasLayer.show()


func run_done():
	stop_music()
	$Timer.wait_time = 2
	$Timer.one_shot = true
	$Timer.start()
	event = "run_done"

func start_puzzle_memories():
	$memories.start()

func cutscene_done(anim_name):
	if anim_name == "kaget_lari":
		$di_kejar.play()
		start_run_minigame()
	elif anim_name == "penasaran":
		$CanvasLayer.hide()
		$run.hide()
		start_puzzle_memories()

func _on_di_kejar_finished():
	$di_kejar.play()

func puzzle_memories_done():
	$CanvasLayer.show()
	$CanvasLayer/HBoxContainer/next.activate()
