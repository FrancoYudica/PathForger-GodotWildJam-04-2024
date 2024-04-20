extends Camera2D

@export_category("Jitter shake")
@export var jitter_shake_curve: Curve

@export var _jitter_shake_duration_ms = 0.0
@export var _jitter_shake_strength_px = 0.0
var _jitter_shake_time_ms = 0.0

func shake():
	_jitter_shake_time_ms = Time.get_ticks_msec()
	

# This next three functions are used for the camera shake
func _process(delta):
	
	# Resets offset every frame
	offset = Vector2(0, 0)
	offset += _get_jitter_shake_offset()

## Applies random centered offset
func _get_jitter_shake_offset() -> Vector2:
	var time_ms = Time.get_ticks_msec()
	var elapsed_time_ms  = float(time_ms - _jitter_shake_time_ms)
	var normalized_time = elapsed_time_ms / _jitter_shake_duration_ms
	
	if normalized_time > 1.0:
		return Vector2.ZERO
	
	# Intensity ranges in [0, 1]
	var intensity = jitter_shake_curve.sample(normalized_time)
	
	var rand_offset = intensity * _jitter_shake_strength_px * Vector2(randf(), randf()).normalized()
	return rand_offset
