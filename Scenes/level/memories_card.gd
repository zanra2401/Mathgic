extends TextureButton

var active: bool = true
@export var active_tex: CompressedTexture2D = null
@export var nonactive_tex: CompressedTexture2D = null
var number: int = 0
var open: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_number(num):
	self.number = num
	$number.text = str(num)

func close_card(first = false):
	if not first:
		$flip.play()
		
	active = false
	open = false
	$number.text = ""
	texture_normal = nonactive_tex

func _on_pressed():
	if not active and not get_parent().get_parent().wait_time:
		open = true
		active = true
		$flip.play()
		$number.text = str(self.number)
		texture_normal = active_tex
		get_parent().get_parent().card_click(self)

