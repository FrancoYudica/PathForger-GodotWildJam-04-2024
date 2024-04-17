extends Node2D
class_name Hookable

signal hookable_reached
signal hookable_left

@export var wants_to_fix_intersection: bool = false

## Point here intersection with hook happened
var _hook_intersection: Vector2 = Vector2.ZERO
var has_player_over: bool = false

## Called when hookable is hooked
func hooked():
	pass

## When player leaves the hookable
func left():
	has_player_over = false
	hookable_left.emit()

## Called when player reaches the hook intersection point
func reached():
	has_player_over = true
	hookable_reached.emit()

## Stores the intersection point in local coordinates
func set_intersection_point(hook_intersection: Vector2):
	_hook_intersection = to_local(hook_intersection)

## Transforms the intersection point to global coordinates
func get_intersection_point() -> Vector2:
	return to_global(_hook_intersection)

## When hookable wants to add any modification to the intersection
## returns the fixed/modifed intersection point with this method
func get_fixed_intersection(current_intersection: Vector2):
	return current_intersection
	
