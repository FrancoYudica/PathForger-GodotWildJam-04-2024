extends Node2D
class_name Hook

## Emitted when a path node is reached after throwing
signal hookable_reached(hookable: Hookable)

## Emitted if after throwing noting is reached
signal miss()

@onready var raycast = $"../RayCast2D"
@onready var length_handler = $HookLengthHandler 
@onready var head_sprite = $Head

@export var length = 270.0

var _intersection_point = null
var _intesecting_object = null
var _animating = false

## Moves the head of the hook to the direction of the point
func throw():
	_animating = true
	length_handler.enlongate()

func _ready():
	length_handler.hook_length = length
	length_handler.connect("recovered", func():
		miss.emit()
		_animating = false
		)
	

func _process(delta):
	
	if not _animating:
		return

	# Updates head sprite position
	var player = $".."
	head_sprite.global_position = player.global_position + player.direction * length_handler.current_length

	length_handler.intersection_length = length
	_intesecting_object = null
	
	# When raycast intersects something
	if raycast.is_colliding():
		
		var intersection_point = raycast.get_collision_point()
		var hit_distance = raycast.to_local(intersection_point).length()
		
		# Ray can't reach target
		if hit_distance > length:
			return
		
		# Updates variables
		var collider = raycast.get_collider()
		if collider == null:
			return
			
		var current_intersection = collider.get_parent()
		_intersection_point = intersection_point
		length_handler.intersection_length = hit_distance
		
		# De focus previous path node
		if current_intersection != _intesecting_object and _intesecting_object != null and _intesecting_object is PathNode:
			var path_node = _intesecting_object as PathNode
			path_node.focused = false
		
		_intesecting_object = current_intersection
		# Fouces current path node
		if _intesecting_object is PathNode:
			var path_node = _intesecting_object as PathNode
			path_node.focused = true
		
		
func _on_hook_head_reached_end():
	
	# When hook reaches the end, it the current intesecting object is a Hookable
	var hookable = _intesecting_object as Hookable
	if _intesecting_object == null or hookable == null:
		length_handler.recover()
		return
	
	# Stops hook animation
	_animating = false
	
	# Positions correctly hook head
	head_sprite.global_position = _intersection_point
	
	# Sets intersection point to hookable
	hookable.hook_intersection = _intersection_point
	hookable.hooked()
	hookable_reached.emit(hookable)
