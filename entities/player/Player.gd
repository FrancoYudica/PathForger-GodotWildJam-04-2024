extends Node2D
class_name Player

@onready var line_path: Line2D = $LinePath
@onready var sprite: Sprite2D = $Sprite2D
@onready var hook: Hook = $Hook
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine

@export var path_node_handler: PathNodeHandler

var current_path_node: PathNode = null

func _ready():
	line_path.add_point(position)
	state_machine.initialize()

func _process(delta):
	
	# Last point position in player
	line_path.set_point_position(line_path.points.size() - 1, position)
