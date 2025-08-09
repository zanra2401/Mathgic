extends Node2D

var last_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.player = self

func animation_select(anim):
	for child in get_children():
		if child.name != anim and child.name in ["idle", "run"]:
			child.hide()
		elif child.name in ["idle", "run"]:
			child.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.x > last_pos.x:
		flip(false)
	else:
		flip(true)
		
	last_pos = global_position

func flip(is_true):
	for child in get_children():
		for sub_child in child.get_children():
			if sub_child.name in ["body", "hair"]:
				sub_child.flip_h = is_true


func _on_area_2d_area_entered(area):
	BattleState.level_stage["level"] = area.get_parent().level
	BattleState.save_location({
		"level": area.get_parent().level,
		"stage": 0,
		"last_position": 0.0
	})
	BattleState.save_game()
	if area.get_parent().level > 0:
		$Play.show_anim()


func _on_area_2d_area_exited(area):
	if area.get_parent().level > 0:
		$Play.hide_anim()



