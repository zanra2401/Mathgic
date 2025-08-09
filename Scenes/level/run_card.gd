extends HBoxContainer

var done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func regenerate():
	var random_right: int = randi() % 5
	var used: Array = [get_parent().jawaban]
	var i = 0
	for child in get_children():
		child.activate()
		if i == random_right:
			child.set_number(get_parent().jawaban)
		else:
			var rand_num: int = randi() % 20 + 1
			while rand_num == get_parent().jawaban and rand_num in used:
				rand_num = randi() % 20 + 1
				
			child.set_number(rand_num)
			used.append(rand_num)
	
		i += 1

func answer(num):
	if num == get_parent().jawaban:
		get_parent().create_soal()
		regenerate()
		get_parent().start_timer()
		get_parent().total_soal -= 1
		get_parent().right()
	else:
		get_parent().wrong()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().total_soal == 0 and not done:
		get_tree().current_scene.run_done()
		get_parent().stop_timer()
		done = true
		get_parent().hide()
