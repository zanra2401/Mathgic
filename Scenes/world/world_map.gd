extends Node2D

var path_follow: PathFollow2D = null
var player: Node2D = null
var destination_scene: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Transisi/Transisi.transition_open_world()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close_world():
	$Transisi/Transisi.transition_close_world()
	

func _on_world_music_finished():
	$world_music.play()

func transition_done(transition):
	if transition == "open_world":
		$world_music.play()
	elif transition == "close_world":
		match destination_scene:
			"level":
				get_tree().change_scene_to_file("res://Scenes/level/level_chapter_1.tscn")
