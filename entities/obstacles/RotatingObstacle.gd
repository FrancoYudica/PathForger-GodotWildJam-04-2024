extends Obstacle

@export var rotate: bool = false
@export var rotations_per_second: float = 0.3

func _process(delta):
	if rotate:
		rotation += 2.0 * PI * delta * rotations_per_second
