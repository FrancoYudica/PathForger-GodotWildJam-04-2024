extends Node2D
class_name Player

@onready var line_path: Line2D = $LinePath
@onready var sprite = $PlayerSprite
@onready var hook: Hook = $Hook
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine

@export var click_buffering_ms: int = 300

var current_hookable: Hookable = null
var buffered_mouse_click = null
var last_buffered_time_ms = 0
var direction: Vector2 = Vector2.UP

func _ready():
	line_path.add_point(position)
	state_machine.initialize()
	hook.global_position = global_position

func _process(delta):
	
	# Last point position in player
	line_path.set_point_position(line_path.points.size() - 1, position)
