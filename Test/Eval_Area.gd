extends Area2D

@export var ID: String
var first: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.get_parent().ID == "card" and BattleState.dragging:
		var card: TextureButton = area.get_parent()
		if ID == "Attack_Area":
			BattleState.inside_attack = true
			BattleState.inside_spell = false
			BattleState.spell.eval_selected = false
			card.inside_attack = true
		else:
			BattleState.inside_spell = true
			BattleState.inside_attack = false
			BattleState.attack.eval_selected = false
			card.inside_spell = true
			
		get_parent().eval_selected = true

func _on_area_exited(area):
	if area.get_parent().ID == "card":
		var card: TextureButton = area.get_parent()
		
		if ID == "Attack_Area":
			BattleState.inside_attack = false
			card.inside_attack = false
		else:
			BattleState.inside_spell = false
			card.inside_spell = false
			
		get_parent().eval_selected = false
