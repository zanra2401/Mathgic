extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_children())
	BattleState.enemies = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
