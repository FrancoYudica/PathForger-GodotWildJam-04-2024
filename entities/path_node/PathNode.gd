extends Hookable
class_name PathNode

@onready var area = $Area2D
@onready var sprite = $PathNodeSprite

var focused: bool:
	set(value):
		if value:
			sprite.open()
		else:
			sprite.close()

## Reached should be called when player is over the node
func reached():
	# Doesn't need collider once it's reached
	disable_collider()
	sprite.reached()

func left():
	sprite.left()

func get_fixed_intersection(current_intersection: Vector2):
	return global_position
