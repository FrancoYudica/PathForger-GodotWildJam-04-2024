## Raycast holds information about the nearest reachable Hookable
## It continously updates to the mouse position and checks if any
## Hookable is in the hook range.
extends RayCast2D
class_name PlayerRaycast

@export var hook_length = 300

@onready var origin = $"../RaycastOriginMarker2D"

var intersecting_hookable: Hookable:
	get:
		return _intersecting_hookable

var direction: Vector2:
	get:
		return (_last_target_position - origin.global_position).normalized()

var _last_target_position: Vector2 = Vector2.ZERO
var _intersecting_hookable: Hookable

func _process(delta):
	global_position = origin.global_position
	
	_last_target_position = get_global_mouse_position()
	look_at(_last_target_position)
		
	_update_raycast_intersection()

## When ray is intersecting, updates hookable and intersection point
func _update_raycast_intersection():
	
	if not is_colliding():
		_set_current_hookable(null)
		return
		
	# Gets collider
	var collider = get_collider()
	if collider == null:
		_set_current_hookable(null)
		return
		
	# Gets parent of collider, that should be a Hookable
	var hookable = collider.get_parent() as Hookable
	if hookable == null:
		_set_current_hookable(null)
		return
	
	# Gets intersection point and fix if necessary
	var intersection_point = get_collision_point()
	var hit_distance = to_local(intersection_point).length()
	
	# Ray can't reach target
	if hit_distance > hook_length:
		_set_current_hookable(null)
		return
	
	# If hookable fixes intersection point, updates point and distance
	if hookable.wants_to_fix_intersection:
		intersection_point = hookable.get_fixed_intersection(intersection_point)
		hit_distance = to_local(intersection_point).length()
	
	hookable.set_intersection_point(intersection_point)
	_set_current_hookable(hookable)

## Changes current hookable focus
func _set_current_hookable(hookable: Hookable):
	
	if hookable == _intersecting_hookable:
		return
	
	# De focus previous path node
	if _intersecting_hookable is PathNode:
		var path_node = _intersecting_hookable as PathNode
		path_node.focused = false
	
	_intersecting_hookable = hookable
		
	# Fouces current path node
	if _intersecting_hookable is PathNode:
		var path_node = _intersecting_hookable as PathNode
		path_node.focused = true
