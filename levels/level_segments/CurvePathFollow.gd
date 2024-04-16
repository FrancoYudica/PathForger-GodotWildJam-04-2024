extends PathFollow2D

@export var speed = 1.0
@export var path_length = 200

var _t = 0.0
func _process(delta):
	
	# Speed is constant
	_t += delta * speed * 200 / path_length
	progress = path_length * (sin(_t) + 1.0) / 2.0
