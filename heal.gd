extends Sprite2D

var caller = null
var affected = null

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(3, 3)
	$AnimationPlayer.play("heal")
	$destroy.wait_time = 0.8
	$destroy.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_destroy_timeout():
	affected.affected_done("heal")
	queue_free()
