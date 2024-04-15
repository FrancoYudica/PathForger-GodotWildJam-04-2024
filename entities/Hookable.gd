extends Node2D
class_name Hookable

## Point here intersection with hook happened
var hook_intersection: Vector2 = Vector2.ZERO

## Called when hookable is hooked
func hooked():
	pass

## Called when player reaches the hook intersection point
func reached():
	disable_collider()

func enable_collider():
	$Area2D.collision_layer = 8
	
func disable_collider():
	$Area2D.collision_layer = 0
	
	
