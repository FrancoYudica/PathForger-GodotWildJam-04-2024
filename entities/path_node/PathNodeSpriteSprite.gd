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

func reached():
	if _tween != null:
		_tween.stop()
	
	var reached_delay = 0.1075
	
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_EXPO)
	_tween.set_ease(Tween.EASE_OUT_IN)
	_tween.tween_property(outline, "scale", Vector2(2.0, 2.0), reached_delay)
	create_tween().tween_property(body, "scale", Vector2(0.0, 0.0), reached_delay)
	
	var radius_tween = create_tween()
	radius_tween.tween_method(_set_inner_radius, .9, .6, reached_delay)
	await radius_tween.finished
	
	radius_tween = create_tween()
	radius_tween.tween_method(_set_inner_radius, .6, .9, 0.2)
	
func left():
	#if _tween != null:
#		await _tween.finished
	create_tween().tween_property(outline, "scale", Vector2(1.0, 1.0), 0.3)
	outline.material.set_shader_parameter("segments_count", 4)

func _set_body_radius(value):
	body.material.set_shader_parameter("radius", value)
	
func _set_segments_count(value):
	outline.material.set_shader_parameter("segments_count", value)

func _set_inner_radius(value):
	outline.material.set_shader_parameter("inner_radius", value)
