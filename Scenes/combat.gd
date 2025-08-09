extends Node2D

var card: Dictionary = {"id": "0"}
var draging: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	BattleState.battleState = BattleState.BattleState.MY_TURN
	BattleState.combat = self
	$Transisi.transition_open_world()
	
func stop_music():
	$music.stop()

func victory_sound():
	$victory_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	pass # Replace with function body.


func _on_music_finished():
	$music.play()

func _on_victory_sound_finished():
	pass # Replace with function body.

func transition_done(transition):
	if transition == "open_world":
		$music.play()
		BattleState.deck.generate_card()
	
