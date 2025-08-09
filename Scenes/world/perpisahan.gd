extends CanvasLayer

var aksa: bool = false

var dialog_aksa: Array = [
	"Aku tahu, Kek. Tapi kalau aku hanya diam di sini… aku akan selamanya menjadi Mono-Add yang lemah.",
	"Buku Mathgic…?",
	"Baik, Kek. Aku akan kembali… dengan semua pilar Mathgic!",
]

var dialog_kakek: Array = [
	"Aksa… kau yakin ingin pergi? Perjalanan ke Gunung Pengetahuan tidak mudah.",
	"Hmph… Kau memang tak punya semua pilar, tapi kau punya sesuatu yang lebih langka: tekad.
	Ini… buku ini adalah catatan perjalananku dulu.",
	"Isinya lengkap, semua pilar ada di situ. Tapi ingat, kau hanya bisa menggunakan apa yang mampu kau panggil.",
	"Heh… aku menunggumu di sini, cucuku. Sekarang pergilah, sebelum aku berubah pikiran."
]
var index_aksa: int = 0
var index_kakek: int = 0

@onready var nama: Label = $PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/nama
@onready var dialog: Label = $PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/dialog
@onready var avatar: TextureRect = $PanelContainer/HBoxContainer/avatar

# Called when the node enters the scene tree for the first time.
func _ready():
	if not BattleState.event_pertama.dialog:
		hide()
		return
		
	avatar.texture = load("res://Scenes/avatar (1).png")
	$"../MenuWorld".hide()
	$"../level2".hide()
	$"../level".hide()
	nama.text = "Kakek"
	dialog.set_story(dialog_kakek[index_kakek])
	index_kakek += 1
	aksa = true

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and BattleState.event_pertama.dialog:
		if dialog.typing:
			dialog.skip()
		else:
			if aksa:
				if index_aksa >= len(dialog_aksa):
					BattleState.done_dialog()
					BattleState.event_pertama.dialog = false
					$"../MenuWorld".show()
					$"../level2".show()
					$"../level".show()
					self.hide()
					return
					
				nama.text = "Aksa"
				avatar.texture = load("res://Scenes/avatar.png")
				dialog.text = ""
				dialog.set_story(dialog_aksa[index_aksa])
				index_aksa += 1
				aksa = false
			else:
				dialog.text = ""
				nama.text = "Kakek"
				avatar.texture = load("res://Scenes/avatar (1).png")
				dialog.set_story(dialog_kakek[index_kakek])
				index_kakek += 1
				aksa = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
