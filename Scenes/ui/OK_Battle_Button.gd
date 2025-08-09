extends Button

var end: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if BattleState.battleState == BattleState.BattleState.LOSE or BattleState.battleState == BattleState.BattleState.WIN:
		end = true
	get_parent().get_parent().get_parent().close_simbol()


func _on_simbol_animation_animation_finished(anim_name):
	if end:
		if BattleState.battleState == BattleState.BattleState.LOSE:
			BattleState.level_stage.stage = 0
			get_tree().change_scene_to_file("res://Scenes/world/world_map.tscn")
		elif BattleState.battleState == BattleState.BattleState.WIN:
			if get_parent().get_parent().get_parent().win_level:
				get_parent().get_parent().get_parent().win_level = false
				get_tree().change_scene_to_file("res://Scenes/world/world_map.tscn")
			else:
				get_tree().change_scene_to_file("res://Scenes/level/level_chapter_1.tscn")
