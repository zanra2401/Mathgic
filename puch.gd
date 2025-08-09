extends Sprite2D

var caller = null
var affected = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("puch")
	$destroy.wait_time = 0.5
	$destroy.one_shot = true
	$destroy.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_destroy_timeout():
	caller.animation_done("attack")
	affected.affected_done("attacked")
	queue_free()
