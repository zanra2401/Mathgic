class_name SaveData
extends Resource

@export var pengalaman: int = 0

@export var PlayerData: Dictionary = {
	"max_hp": 25,
	"max_inti": 4,
	"base_damage": 8,
	"defense": 2
}

@export var locationData: Dictionary = {
	"level": 0,
	"stage": 0,
	"last_position": 0.0
}

@export var upgrade: Dictionary = {
	"max_hp": 5,
	"max_inti": 50,
	"base_damage": 6,
	"defense": 8
}

@export var last_upgrade: Dictionary = {
	"max_hp": 5,
	"max_inti": 50,
	"base_damage": 6,
	"defense": 8
}

@export var event_pertama: Dictionary = {
	"dialog": true,
	"prolog": true,
	"battle": true,
	"run": true,
	"memories": true 
}

@export var level_done: Array = []
