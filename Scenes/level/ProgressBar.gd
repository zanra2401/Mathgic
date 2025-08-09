extends ProgressBar

var last_stage: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var stage: int = get_tree().current_scene.stage
	last_stage = stage
	update_progress()
	
func update_progress():
	var percentage = 100 / get_tree().current_scene.total_stage
	value = percentage * last_stage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().current_scene.stage != last_stage:
		var stage: int = get_tree().current_scene.stage
		last_stage = stage
		update_progress()
