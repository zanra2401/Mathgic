extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tree_1_area_entered(area):
	print("A")
	modulate = Color(1, 1, 1, 0.6)


func _on_tree_1_area_exited(area):
	modulate = Color(1, 1, 1, 1)


func _on_tree_2_area_entered(area):
	modulate = Color(1, 1, 1, 0.6)


func _on_tree_2_area_exited(area):
	modulate = Color(1, 1, 1, 1)


func _on_tree_3_area_entered(area):
	modulate = Color(1, 1, 1, 0.6)


func _on_tree_3_area_exited(area):
	modulate = Color(1, 1, 1, 1)


func _on_tree_4_area_entered(area):
	modulate = Color(1, 1, 1, 0.6)


func _on_tree_4_area_exited(area):
	modulate = Color(1, 1, 1, 1)
