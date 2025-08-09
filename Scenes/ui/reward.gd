extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	if not get_parent().get_parent().win_level:
		var pengalaman: int = randi() % 2 + 1
		$Label.text = str(pengalaman)
		get_parent().get_parent().temp_pengalaman = pengalaman

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
