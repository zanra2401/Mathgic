extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().current_scene.name == "World_Map":
		$PanelContainer/CenterContainer/VBoxContainer/Button3.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	hide()


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/world/world_map.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui/main.tscn")


