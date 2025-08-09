extends CanvasLayer

var jawaban: int = 0
var total_soal: int = 10
var done: bool = false

@onready var soal: Label = $Soal

# Called when the node enters the scene tree for the first time.
func start():
	done = false
	show()
	BattleState.battleState = BattleState.BattleState.MY_TURN
	start_timer()
	create_soal()
	$run_card.regenerate()

func start_timer():
	$time.time_start()

func stop_timer():
	$time/time.stop()

func create_soal():
	var first_number: int = randi() % 5 + 5
	var second_number: int = randi() % 5 + 5
	jawaban = first_number + second_number
	soal.text = str(first_number) + " + " + str(second_number) 

func wrong():
	$hp.value -= 1

func right():
	$hp.value += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $hp.value < 1 and not done:
		BattleState.Player.hp = BattleState.Player.max_hp
		BattleState.Player.inti = BattleState.Player.max_inti
		BattleState.pengalaman_colected = 0
		get_parent().transisi.end_combat("lose")
		done = true
		get_tree().current_scene.stop_music()
		BattleState.battleState = BattleState.BattleState.LOSE


func _on_time_timeout():
	$hp.value -= 1
	start_timer()
	create_soal()
	$run_card.regenerate()
