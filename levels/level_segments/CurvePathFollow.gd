extends PathFollow2D

@onready var path_node = $PathNode

@export var speed = 1.0
@export var path_length = 200
@export var level_changer: LevelChanger

var start_move_when_reached: bool:
	set(value):
		_moving_when_reached = value
		if _moving_when_reached:
			_moving = false


var _t = 0.0
var _moving = true
var _moving_when_reached = false

static var pi_4_over_3 = PI * 1.5

func _ready():
	path_node.connect("hookable_left", _hookable_left)
	path_node.connect("hookable_reached", _hookable_reached)
	

func _process(delta):

	if not _moving:
		return
	
	# Speed is constant
	_t += delta * speed * 200 / path_length * level_changer.difficulty
	progress = path_length * (sin(_t + pi_4_over_3) + 1.0) / 2.0

func _hookable_left():
	_moving = false
	
func _hookable_reached():
	if _moving_when_reached:
		_moving = true
