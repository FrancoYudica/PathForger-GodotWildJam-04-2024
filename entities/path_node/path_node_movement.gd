extends Node2D

@onready var edge_1_sprite: Sprite2D = $Edge1
@onready var edge_2_sprite: Sprite2D = $Edge2

@export var path_node: PathNode
@export var curve: Curve
@export var speed: float = 1.0

var _t: float = 0.0
var _path_length: float
var _in_edge_1 = true

func _ready():
	position = global_position
	top_level = true
	_path_length = edge_1_sprite.to_local(edge_2_sprite.position).length()

func _process(delta):
	
	# Changes t
	_t += delta * speed
	
	# Loops
	if _t > 1.0:
		_in_edge_1 = not _in_edge_1
		_t = 0.0
	
	_t = clampf(_t, 0.0, 1.0)
	
	var value = curve.sample(_t)
	
	# Interpolates position with the curve value
	var pos_1 = edge_1_sprite.global_position
	var pos_2 = edge_2_sprite.global_position
	
	if not _in_edge_1:
		pos_1 = edge_2_sprite.global_position
		pos_2 = edge_1_sprite.global_position
		
	path_node.position = pos_1 + (pos_2 - pos_1) * value
