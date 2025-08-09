extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_setting_pressed():
	$"../Menu".show()


func _on_upgrade_pressed():
	$"../upgrade".show()


func _on_book_pressed():
	$"../Book".show()
