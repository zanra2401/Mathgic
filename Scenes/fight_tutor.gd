extends Node2D

var tutor: Dictionary = {
	"full_image": {
		"top": Vector2(-12, -1115),
		"bottom": Vector2(4, 1051),
		"left": Vector2(-587, -5),
		"right": Vector2(603, -10),
		"text": "top",
		"tutor": ""
	},
	"health": {
		"top": Vector2(0, -573),
		"bottom": Vector2(-145, 656),
		"left": Vector2(-511, -29),
		"right": Vector2(140, -31),
		"text": "top",
		"tutor": "Kartu Nyawa: ini adalah kartu yang menandai sisa dari Nyawa kamu jika angka di kartu ini 0 maka game over."
	},
	"deck": {
		"top": Vector2(0, -407),
		"bottom": Vector2(-1, 958),
		"left": Vector2(-536, -21),
		"right": Vector2(535, -34),
		"text": "top",
		"tutor": "Ini adalah Deck kamu kamu bisa drag and drop kartu kartu ini ke kartu Skill dan kartu Serangan"
	},
	"skill": {
		"top": Vector2(7, -579),
		"bottom": Vector2(4, 661),
		"left": Vector2(-381, -28),
		"right": Vector2(281, -54),
		"text": "top",
		"tutor": "Kartu Skill: ini adalah kartu skill kamu, kamu dapat drag and drop kartu ini ke musuh dan ke kartu nyawa, jika skill buff drag ke kartu nyawa jika skill merusak drag ke musuh, contoh skill heal bangun angka 11 dan drag ke kartu nyawa, angka skil terdapat pada buku kamu dapat melihat skill saat di peta dunia"
	},
	"attack": {
		"top": Vector2(7, -579),
		"bottom": Vector2(4, 661),
		"left": Vector2(-247, -28),
		"right": Vector2(407, -36),
		"text": "top",
		"tutor": "Kartu Serangan: ini adalah kartu serangan mu kamu harus membangun kartu yang sama seperti yang muncul di musuh untuk memberikan kerusakan, dengan mengambil kartu dari deck"
	},
	"end_turn": {
		"top": Vector2(7, -579),
		"bottom": Vector2(4, 661),
		"left": Vector2(-114, -2),
		"right": Vector2(530, -6),
		"text": "top",
		"tutor": "Kartu Giliran: klik kartu ini untuk mengakhiri giliran"
	},
	"inti": {
		"top": Vector2(-3, -616),
		"bottom": Vector2(13, 503),
		"left": Vector2(-321, -20),
		"right": Vector2(357, -40),
		"text": "top",
		"tutor": "ini adalah inti, kamu butuh inti untuk menggunakan kartu dari deck, jika inti mu habis kamu harus mengakhiri giliran untuk mengisi ulang"
	},
	"musuh": {
		"top": Vector2(-1, -982),
		"bottom": Vector2(-4, 418),
		"left": Vector2(-381, -18),
		"right": Vector2(378, -19),
		"text": "bottom",
		"tutor": "kartu atas adalah kartu yang angka nya harus kamu samakan dengan kartu serangan lalu drag kartu serangan mu ke musuh untuk memeberi kerusakan, kartu bawah adalah kartu nyawa musuh"
	},
	
}

var ind: Array = ["kartu","full_image", "health", "deck", "skill", "attack", "end_turn", "inti", "musuh"]
var ind_now: int = 0
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer3/Transisi.transition_open_world()
	new_tutor()

func new_tutor():
	if ind_now >= len(ind):
		$CanvasLayer3/Transisi.transition_close_world()
		return
		
	if ind[ind_now] != "kartu":
		$CanvasLayer.hide()
		var tween = create_tween()
		tween.parallel().tween_property($top, "position", tutor[ind[ind_now]]['top'], 0.5)
		tween.parallel().tween_property($left, "position", tutor[ind[ind_now]]['left'], 0.5)
		tween.parallel().tween_property($right, "position", tutor[ind[ind_now]]['right'], 0.5)
		tween.parallel().tween_property($bottom, "position", tutor[ind[ind_now]]['bottom'], 0.5)
		if tutor[ind[ind_now]]['text'] == "top":
			$bot_tex.hide()
			$top_tex.show()
			$top_tex.text = tutor[ind[ind_now]]['tutor']
		else:
			$top_tex.hide()
			$bot_tex.show()
			$bot_tex.text = tutor[ind[ind_now]]['tutor']
	else:
		$CanvasLayer.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_pressed():
	
	if ind_now + 1 == len(ind) - 1:
		$CanvasLayer2/next.text = "OK"
		
	ind_now += 1
	new_tutor()


func _on_back_pressed():
	if ind_now <= 0:
		return
	ind_now -= 1
	new_tutor()

func transition_done(anim):
	if anim == "close_world":
		BattleState.done_battle()
		BattleState.event_pertama.battle = false
		get_tree().change_scene_to_file("res://Scenes/combat.tscn")
