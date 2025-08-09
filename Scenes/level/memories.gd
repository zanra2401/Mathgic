extends CanvasLayer

var random_card_number: Array = []
var first_selected: TextureButton = null
var second_selected: TextureButton = null

var target: int = 0
var done: bool = false
var rewards: int = 6
var wait_hint: bool = false
var wait_win: bool = false
var wait_time: bool = false
var wait_generate: bool = false

# Called when the node enters the scene tree for the first time.
func start():
	done = false
	rewards = 6
	show()
	$reward/reward.text = str(rewards)
	generate_card()
	make_target(true)

func generate_card():
	for i in range(12):
		var random_num: int = randi() % 5 + 5
		random_card_number.append(random_num)
		$GridContainer.get_child(i).set_number(random_num)
		$GridContainer.get_child(i).open = false
		$Timer.wait_time = 4
		$Timer.one_shot = true
		wait_generate = true
		$Timer.start()
		
func make_target(first):
	var random_child: int = randi() % 12
	var random_second_child: int = randi() % 12
	
	while $GridContainer.get_child(random_child).open:
		random_child = randi() % 12 
	
	while $GridContainer.get_child(random_second_child).open or random_second_child == random_child:
		random_second_child = randi() % 12 
	
	target = $GridContainer.get_child(random_child).number + $GridContainer.get_child(random_second_child).number
	$TextureButton.set_number(target, first)

func card_click(card):
	if first_selected == null:
		first_selected = card
	else:
		if first_selected.number + card.number == target:
			first_selected = null
			if not check_win():
				make_target(false)
		else:
			second_selected = card
			$Timer.wait_time = 1
			$Timer.one_shot = true
			wait_hint = true
			wait_time = true
			$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if check_win() and not done:
		done = true
		$Timer.wait_time = 1
		$Timer.one_shot = true
		$Timer.start()
		wait_time = true
		wait_win = true
		BattleState.pengalaman_colected += rewards
		get_tree().current_scene.set_pengalaman()
		


func check_win():
	for child in $GridContainer.get_children():
		if not child.open:
			return false
			
	return true


func close_all_card():
	for child in $GridContainer.get_children():
		child.close_card(true)


func _on_timer_timeout():
	if wait_hint:
			first_selected.close_card()
			second_selected.close_card()
			if rewards > 0:
				rewards -= 1
				
			$reward/reward.text = str(rewards)
			first_selected = null
			second_selected = null
			wait_hint = false
			wait_time = false
	elif wait_win:
		hide()
		wait_win = false
		get_tree().current_scene.puzzle_memories_done()
		wait_time = false
	elif wait_generate:
		wait_generate = false
		close_all_card()

