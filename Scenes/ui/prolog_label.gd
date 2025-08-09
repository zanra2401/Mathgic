extends Label

const typing_speed: float = 0.03

var text_story: String = ""
var index: int = 0
var typing: bool = false

	
func set_story(text_story):
	self.text_story= text_story
	typing = true
	$Timer.wait_time = typing_speed
	$Timer.one_shot = true
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func skip():
	if typing:
		$Timer.stop()
		text = text_story
		typing = false
		index = 0

func _on_timer_timeout():
	if index < len(text_story):
		text += text_story[index]
		$Timer.wait_time = typing_speed
		$Timer.one_shot = true
		$Timer.start()
		index += 1
	elif index == len(text_story):
		index = 0
		typing = false
