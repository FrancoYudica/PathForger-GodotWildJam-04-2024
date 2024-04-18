extends ChangingObstacle

@export var rotations_per_second: float = 0.3

func _process(delta):
	rotation += 2.0 * PI * delta * rotations_per_second * level_changer.difficulty
