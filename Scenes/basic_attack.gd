extends Sprite2D

var caller = null
var affected = null

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(3, 3)
	$AnimationPlayer.play("attacked")
	$destroy.wait_time = 1
	$destroy.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_destroy_timeout():
	affected.affected_done("attacked")
	queue_free()
