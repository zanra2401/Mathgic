extends Node2D

@onready var prolog: Label = $Story/MarginContainer/PanelContainer/prolog_label
var card_anim: bool = false
var showed_card: bool = false

var stories: Array = [
	"Di dunia Numeria, semua orang terlahir dengan empat pilar Mathgic: Add, Sub, Mul, dan Div.
	Dari kartu-kartu ini, angka dibentuk… dan kekuatan tercipta.",
	"show card",
	"Tapi aku… hanya terlahir dengan Add.
	Mereka menyebutku Mono-Add… lemah, tak berguna, tak pantas masuk Akademi Mathgic.",
	"Namun kakek pernah bercerita tentang Gunung Pengetahuan…
	Tempat semua pilar Mathgic bisa ditemukan… jika cukup kuat untuk sampai ke puncaknya.",
	"Aku… Aksa. Dan hari ini, aku memulai perjalanan itu."
]

var state: int = 0
var started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Transisi.transition_open_world()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not card_anim and started:
			if prolog.typing:
				prolog.skip()
			else:
				if not showed_card:
					state += 1
				if stories[state] == "show card":
					$Story.hide()
					if not showed_card:
						$card2.play("show_card")
						card_anim = true
					else:
						$card2.play_backwards("show_card")
						card_anim = true
				elif not card_anim:
					if showed_card:
						state += 1
						
					if state >= len(stories):
						$CanvasLayer/Transisi.transition_close_world()
						return
						
					$Story.show()
					prolog.text = ""
					prolog.set_story(stories[state])

func _on_card_2_animation_finished(anim_name):
	if not showed_card:
		showed_card = true
	else:
		state += 1
		prolog.text = ""
		$Story.show()
		prolog.set_story(stories[state])
		
	card_anim = false

func transition_done(anim):
	if anim == "open_world":
		started = true
		prolog.set_story(stories[state])
	else:
		get_tree().change_scene_to_file("res://Scenes/world/world_map.tscn")
