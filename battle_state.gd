extends Node

enum BattleState { MY_TURN, ENEMY_TURN, LOSE, WIN }

var save_data: SaveData 

var Player = {}

var upgrade: Dictionary
var last_upgrade: Dictionary
var total_pengalaman: int

var pengalaman_colected: int = 0

var level_stage: Dictionary

var reward_battle: int = 0

var battleState = BattleState.MY_TURN
var enemy_turn: int = -1
var can_play_sound: bool = false

# attack / skill
var basic_attack = preload("res://Scenes/attack/basic_attack.tscn")
var puch = preload("res://Scenes/attack/puch.tscn")

var active_card: Dictionary = {}
var dragged_card: Dictionary = {}
var inside_enemy: bool = false
var inside_attack: bool = false
var inside_spell: bool = false
var dragging: bool = false

var cards: Dictionary = {}

var spell: MarginContainer = null
var attack: MarginContainer = null
var enemy_selected: Control = null
var deck: PanelContainer = null
var enemies: HBoxContainer = null
var status_player: Control = null
var hp: TextureButton = null
var transition: Node2D = null
var combat: Node2D = null
var drag_type = null


var event_pertama: Dictionary = {
	"dialog": false,
	"prolog": false,
	"tutor_fight": true,
	"tutor_run": true,
	"tutor_meories": true 
}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_save()
	Player = {
		"max_hp": save_data.PlayerData.max_hp,
		"hp": save_data.PlayerData.max_hp,
		"max_inti": save_data.PlayerData.max_inti,
		"inti": save_data.PlayerData.max_inti,
		"base_damage": save_data.PlayerData.base_damage,
		"defense": save_data.PlayerData.defense,
	}
	
	level_stage =  {
		"level": save_data.locationData.level,
		"stage": save_data.locationData.stage,
		"last_position": save_data.locationData.last_position
	}
	
	print(level_stage.level)
	
	upgrade = {
		"max_hp": save_data.upgrade.max_hp,
		"max_inti": save_data.upgrade.max_inti,
		"base_damage": save_data.upgrade.base_damage,
		"defense": save_data.upgrade.defense
	}
	
	last_upgrade = {
		"max_hp": save_data.last_upgrade.max_hp,
		"max_inti": save_data.last_upgrade.max_inti,
		"base_damage": save_data.last_upgrade.base_damage,
		"defense": save_data.last_upgrade.defense
	}
	
	total_pengalaman = save_data.pengalaman
	pass # Replace with function body.

func load_save():
	if FileAccess.file_exists("user://save_data.tres"):
		save_data = load("user://save_data.tres")
	else:
		save_data = SaveData.new()
		save_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if combat != null:
		if is_enemy_dead():
			Player.inti = 4
			return
			
		if is_palyer_dead():
			Player.inti = 4
			return
			
		if battleState == BattleState.ENEMY_TURN and enemy_turn == -1:
			var i = 1
			for child in enemies.get_children():
				if child.ID == "enemy":
					child.turn = i
					child.turning = false
					if i == len(enemies.get_children()):
						child.next = -1
					else:
						child.next = i + 1
				i += 1
			enemy_turn = 1
				

func is_enemy_dead():
	if len(enemies.get_children()) == 0 and battleState != BattleState.WIN:
		transition.end_combat("win")
		battleState = BattleState.WIN
		combat.stop_music()
		combat.victory_sound()
		combat = null
		return true
	return false
	
func is_palyer_dead():
	if Player.hp <= 0 and battleState != BattleState.LOSE:
		Player.hp = Player.max_hp
		Player.inti = Player.max_inti
		pengalaman_colected = 0
		transition.end_combat("lose")
		battleState = BattleState.LOSE
		combat.stop_music()
		combat = null
		return true
	return false

const levels: Dictionary = {
	0: {
		"pos": 0
	},
	
	1: {
		"uniq_event": [1],
		1: "run",
		"pos": 199
	}
}

func save_Player(Player):
	save_data.PlayerData = Player

func save_game():
	ResourceSaver.save(save_data, "user://save_data.tres", ResourceSaver.FLAG_COMPRESS)

func save_location(Location):
	save_data.locationData = Location


func save_pengalaman():
	save_data.pengalaman = total_pengalaman

	
func save_updarade():
	save_data.last_upgrade = last_upgrade
	save_data.upgrade = upgrade

	
func win_level():
	total_pengalaman += pengalaman_colected
	save_pengalaman()
	var level_stage_save =  {
		"level": save_data.locationData.level,
		"stage": 0,
		"last_position": 0.0
	}
	save_location(level_stage_save)
	save_game()
	Player.hp = Player.max_hp
	Player.inti = Player.max_inti
	level_stage.staget = 0
	level_stage.last_position = 0.0
	pengalaman_colected = 0

func reset_combat():
	battleState = BattleState.MY_TURN
	enemy_turn = -1
	can_play_sound = false
	active_card = {}
	dragged_card = {}
	inside_enemy = false
	inside_attack = false
	inside_spell = false
	dragging = false
	cards = {}
