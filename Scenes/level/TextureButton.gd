extends TextureButton

var active: bool = true
@export var active_tex: CompressedTexture2D = null
@export var nonactive_tex: CompressedTexture2D = null
var num: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_number(num):
	self.num = num
	$number.text = str(num)

func activate():
	texture_normal = active_tex

func _on_pressed():
	if active:
		$flip.play()
		$number.text = ""
		texture_normal = nonactive_tex
		get_parent().answer(num)

