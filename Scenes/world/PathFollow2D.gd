extends PathFollow2D

const speed: float = 1
var is_traveling: bool = false
var destination: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	progress = BattleState.levels[BattleState.level_stage.level].pos
	get_tree().current_scene.path_follow = self

func travel(destination):
	self.destination = destination
	is_traveling = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if destination == progress:
		is_traveling = false
		get_tree().current_scene.player.animation_select("idle")
		
	if is_traveling:
		if progress > destination:
			progress -= speed
		else:
			progress += speed
