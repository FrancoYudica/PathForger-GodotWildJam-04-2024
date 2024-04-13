extends VisibleOnScreenNotifier2D
class_name PathNode

@onready var area = $Area2D

## Reached should be called when player is over the node
func reached():
	area.monitorable = false
	modulate = Color.AQUAMARINE
