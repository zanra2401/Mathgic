extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func time_start():
	$time.wait_time = 5
	$time.one_shot = true
	$time.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.value = $time.time_left
	if $time.time_left < 2:
		$TextureProgressBar.modulate = Color(0.8, 0.5, 0.5)
	else:
		$TextureProgressBar.modulate = Color(1, 1, 1)
