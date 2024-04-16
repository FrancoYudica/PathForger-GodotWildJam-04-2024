extends Node2D
class_name Hookable

@export var wants_to_fix_intersection: bool = false

## Point here intersection with hook happened
var hook_intersection: Vector2 = Vector2.ZERO

## Called when hookable is hooked
func hooked():
	pass

## When player leaves the hookable
func left():
	pass

## Called when player reaches the hook intersection point
func reached():
	disable_collider()

func enable_collider():
	$Area2D.collision_layer = 8
	
func disable_collider():
	$Area2D.collision_layer = 0

## When hookable wants to add any modification to the intersection
## returns the fixed/modifed intersection point with this method
func get_fixed_intersection(current_intersection: Vector2):
	return current_intersection
	
