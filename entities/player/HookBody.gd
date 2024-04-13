extends Line2D

@export var start_node: Node2D
@export var end_node: Node2D

func _ready():
	add_point(start_node.global_position)
	add_point(end_node.global_position)
	
func _process(_delta):
	set_point_position(0, start_node.global_position)
	set_point_position(1, end_node.global_position)
