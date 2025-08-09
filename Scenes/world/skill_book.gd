extends TextureButton

@export var skill_name: String = "Heal I"
@export var number_need: String = "11"
@export var description: String = "Heal 1"

# Called when the node enters the scene tree for the first time.
func _ready():
	$skillName.text = skill_name
	$number.text = number_need
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	$"../../../../description/MarginContainer/desc".text = description
	$clik.play()
