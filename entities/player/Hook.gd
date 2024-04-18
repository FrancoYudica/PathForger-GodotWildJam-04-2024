extends Node2D
class_name Hook

## Emitted when a path node is reached after throwing
signal hookable_reached(hookable: Hookable)

## Emitted if after throwing noting is reached
signal miss()

@onready var raycast = $"../PlayerRayCast2D"
@onready var length_handler = $HookLengthHandler 
@onready var head_sprite = $Head

@export var length = 270.0

var _intersection_point = null
var _intersecting_hookable = null
var _animating = false

## Moves the head of the hook to the direction of the point
func throw():
	show()
	_animating = true
	length_handler.enlongate()

func _ready():
	length_handler.hook_length = length
	length_handler.connect("recovered", func():
		miss.emit()
		hide()
		_animating = false
		)
	

func _process(delta):
	
	if _animating:
		# Updates head sprite position along the hook direction
		var player = $".."
		head_sprite.global_position = player.global_position + player.raycast.direction * length_handler.current_length
	
	# Resets variables when ray misses
	if not _update_raycast_intersection():
		length_handler.hit_distance = length
		_set_current_hookable(null)

		
func _on_hook_head_reached_end():
	
	# When hook reaches the end, it the current intesecting object is a Hookable
	var hookable = _intersecting_hookable as Hookable
	if _intersecting_hookable == null or hookable == null:
		length_handler.recover()
		return
	
	# Stops hook animation
	_animating = false
	
	# Sets intersection point to hookable
	hookable.set_intersection_point(_intersection_point)
	hookable.hooked()
	hookable_reached.emit(hookable)

## When ray is intersecting, updates hookable and intersection point
func _update_raycast_intersection():
	
	if not raycast.is_colliding():
		return false
		
	# Gets collider
	var collider = raycast.get_collider()
	if collider == null:
		return false
		
	# Gets parent of collider, that should be a Hookable
	var hookable = collider.get_parent() as Hookable
	if hookable == null:
		return false
	
	# Gets intersection point and fix if necessary
	var intersection_point = raycast.get_collision_point()
	var hit_distance = raycast.to_local(intersection_point).length()
	
	# Ray can't reach target
	if hit_distance > length:
		return false
	
	# If hookable fixes intersection point, updates point and distance
	if hookable.wants_to_fix_intersection:
		intersection_point = hookable.get_fixed_intersection(intersection_point)
		hit_distance = raycast.to_local(intersection_point).length()
		
	_intersection_point = intersection_point
	
	if _animating:
		length_handler.hit_distance = hit_distance
	
	_set_current_hookable(hookable)
	return true

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
