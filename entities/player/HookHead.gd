extends Node2D

signal reached_end
signal recovered

@export var curve: Curve
@export var recover_curve: Curve
@export var duration: float = 0.3
@export var recover_duration: float = 0.3

var hook_length: float = 300
var hit_distance = 0.0
var _enlongating = false
var _recovering = false
var _t = 0.0

var progress: float:
	get:
		return curve.sample(_t)

var current_length: float:
	get:
		return progress * hit_distance
		

func enlongate():
	_enlongating = true
	_t = 0.0
	
func recover():
	_recovering = true
	_t = 1.0
	
func _process(delta):

	if _enlongating:

		_t += delta / duration
		_t = clampf(_t, 0.0, 1.0)
		
		if _t == 1.0:
			_enlongating = false
			reached_end.emit()
		
	elif _recovering:
		_t -= delta / recover_duration
		_t = clampf(_t, 0.0, 1.0)
		
		if _t == 0.0:
			_recovering = false
			recovered.emit()
		
		
	
