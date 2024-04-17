extends Hookable
class_name Obstacle

@export var dynamic_difficulty = 0.0
@export var max_dynamic_difficulty = 5.0

## Called when player reaches the hook intersection point
func reached():
	super.reached()
