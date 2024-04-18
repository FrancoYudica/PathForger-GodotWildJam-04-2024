extends Node2D
class_name Hook

@onready var head = $Head
@onready var body: Line2D = $Body
@onready var player = $".."

var head_global_position: Vector2:
	get:
		return head.global_position
	set(end_point):
		head.global_position = end_point
		body.set_point_position(1, end_point)

var length: float:
	set(value):
		head_global_position = player.global_position + player.raycast.direction * value
		

func _ready():
	body.add_point(player.global_position)
	body.add_point(player.global_position)
	hide()
	

func _process(_delta):
	body.set_point_position(0, player.global_position)
