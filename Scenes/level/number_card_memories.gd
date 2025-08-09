extends TextureButton

var active: bool = true
@export var active_tex: CompressedTexture2D = null
@export var nonactive_tex: CompressedTexture2D = null
var number: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_number(num, first = false):
	self.number = num
	$number.text = str(num)
	texture_normal = active_tex
	if not first:
		$flip.play()
	


