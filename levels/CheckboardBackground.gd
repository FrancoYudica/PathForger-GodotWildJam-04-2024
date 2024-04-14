extends Sprite2D

@export var curve: Curve

var _tween: Tween
var _moving_rows = true

func _ready():
	_setup_tween()

func _setup_tween():
	
	
	_moving_rows = not _moving_rows
	
	var t = 0.0
	if _moving_rows:
		t = material.get_shader_parameter("rows_offset_strength")
	else:
		t = material.get_shader_parameter("columns_offset_strength")
		
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_CUBIC)
	_tween.tween_method(_set_tween_offset_strength, t, 1.0 - t, 0.75)
	_tween.connect("finished", _tween_finished)
	

func _tween_finished():
	await get_tree().create_timer(.5).timeout
	_setup_tween()

func _set_tween_offset_strength(t: float):
	if (_moving_rows):
		material.set_shader_parameter("rows_offset_strength", t)
	else:
		material.set_shader_parameter("columns_offset_strength", t)
	
	
