extends CanvasLayer

@onready var hp_unit: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/hp/HBoxContainer/unit
@onready var hp_need: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/hp/HBoxContainer2/need
@onready var attack_unit: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/attack/HBoxContainer/unit
@onready var attack_need: Label =$CenterContainer/PanelContainer/MarginContainer/VBoxContainer/attack/HBoxContainer2/need
@onready var defense_unit: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/deffense/HBoxContainer/unit
@onready var defense_need: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/deffense/HBoxContainer2/need
@onready var inti_unit: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/inti/HBoxContainer/unit
@onready var inti_need: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/inti/HBoxContainer2/need
@onready var pengalaman: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Control/pengalaman

var last_hp: int 
var last_damage: int
var last_defense: int
var last_inti: int


# Called when the node enters the scene tree for the first time.
func _ready():
	last_hp = BattleState.upgrade.max_hp
	last_damage = BattleState.upgrade.base_damage
	last_defense = BattleState.upgrade.defense
	last_inti = BattleState.upgrade.max_inti
	update()
	
func update():
	hp_unit.text = str(BattleState.Player.max_hp)
	hp_need.text = str(BattleState.upgrade.max_hp)
	attack_unit.text = str(BattleState.Player.base_damage)
	attack_need.text = str(BattleState.upgrade.base_damage)
	defense_unit.text = str(BattleState.Player.defense)
	defense_need.text = str(BattleState.upgrade.defense)
	inti_unit.text = str(BattleState.Player.max_inti)
	inti_need.text = str(BattleState.upgrade.max_inti)
	pengalaman.text = str(BattleState.total_pengalaman)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tambah_hp_pressed():
	if BattleState.total_pengalaman > 0:
		BattleState.total_pengalaman -= 1
		BattleState.upgrade.max_hp -= 1
		if BattleState.upgrade.max_hp <= 0:
			BattleState.upgrade.max_hp = last_hp + 3
			last_hp += 3
			BattleState.Player.max_hp += 1
			BattleState.Player.hp += 1
		update()


func _on_tambah_attack_pressed():
	if BattleState.total_pengalaman > 0:
		BattleState.total_pengalaman -= 1
		BattleState.upgrade.base_damage -= 1
		if BattleState.upgrade.base_damage <= 0:
			BattleState.upgrade.base_damage = last_hp + 5
			last_hp += 5
			BattleState.Player.base_damage += 1
		update()


func _on_tambah_defense_pressed():
	if BattleState.total_pengalaman > 0:
		BattleState.total_pengalaman -= 1
		BattleState.upgrade.defense -= 1
		if BattleState.upgrade.defense <= 0:
			BattleState.upgrade.defense = last_defense + 6
			last_defense += 6
			BattleState.Player.defense += 1
		update()

func reset():
	BattleState.last_upgrade = BattleState.save_data.last_upgrade
	BattleState.upgrade = BattleState.save_data.upgrade
	BattleState.total_pengalaman = BattleState.save_data.pengalaman
	update()
	
func _on_button_pressed():
	if BattleState.total_pengalaman > 0:
		BattleState.total_pengalaman -= 1
		BattleState.upgrade.max_inti -= 1
		if BattleState.upgrade.max_inti <= 0:
			BattleState.upgrade.max_inti = last_inti + 50
			last_hp += 50
			BattleState.Player.max_inti += 1
			BattleState.Player.inti += 1
		update()


func _on_simpan_pressed():
	BattleState.save_updarade()
	BattleState.save_pengalaman()
	
	var Player = {
		"max_hp": BattleState.Player.max_hp,
		"max_inti": BattleState.Player.max_inti,
		"base_damage": BattleState.Player.base_damage,
		"defense": BattleState.Player.defense,
	}
	
	BattleState.save_Player(Player)
	BattleState.save_game()
	hide()

func _on_batal_pressed():
	reset()
	hide()
