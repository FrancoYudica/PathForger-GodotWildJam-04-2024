extends Node2D

@onready var outline = $Outline
@onready var body = $Body

var _tween: Tween = null

func open():
	if _tween != null:
		_tween.stop()
	outline.material.set_shader_parameter("rotation_speed", 10)
	_tween = create_tween()
	_tween.tween_property(outline, "scale", Vector2(1.6, 1.6), 0.05)
	_tween.tween_property(body, "scale", Vector2(1.3, 1.3), 0.1)
	_tween.tween_method(_set_body_radius, 0.5, 0.75, .2)
	
func close():
	if _tween != null:
		_tween.stop()
	outline.material.set_shader_parameter("rotation_speed", 2)
	_tween = create_tween()
	_tween.tween_property(outline, "scale", Vector2(1.3, 1.3), 0.1)
	_tween.tween_property(body, "scale", Vector2(1, 1), 0.1)
	_tween.tween_method(_set_body_radius, .75, 0.5, .5)

func _set_body_radius(value):
	body.material.set_shader_parameter("radius", value)
