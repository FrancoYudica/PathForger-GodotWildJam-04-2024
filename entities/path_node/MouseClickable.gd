extends Node2D

signal mouse_enter
signal mouse_exit

@export var radius = 40
@export var monitoring = true

var _hovered = false

func _process(delta):
	
	if not monitoring:
		return
		
	var now_hovered = (get_global_mouse_position() - global_position).length_squared() < radius * radius
	
	# Emits signal when state changes
	if not _hovered and now_hovered:
		mouse_enter.emit()
	if _hovered and not now_hovered:
		mouse_exit.emit()
	
	_hovered = now_hovered
	
