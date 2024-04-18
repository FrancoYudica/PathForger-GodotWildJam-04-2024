extends RayCast2D
class_name PlayerRaycast

@onready var origin = $"../RaycastOriginMarker2D"

var can_rotate: bool = true

var direction: Vector2:
	get:
		return (_last_target_position - origin.global_position).normalized()

var _last_target_position: Vector2 = Vector2.ZERO

func _process(delta):
	global_position = origin.global_position
	
	if can_rotate:
		_last_target_position = get_global_mouse_position()
		look_at(_last_target_position)
		
