extends Node2D

@export var path_node_handler: PathNodeHandler
@export var nodes_vertical_gap: int = 80
@onready var first_path_node: PathNode = $FirstPathNode

var path_node_packed = preload("res://entities/path_node/path_node.tscn")

func _ready():
	first_path_node.reparent(path_node_handler)
	path_node_handler.add_path_node(first_path_node)
	
	for i in range(1, 20):
		var y = first_path_node.position.y - i * nodes_vertical_gap
		var x = randf_range(30.0, 150.0)
		var path_node: PathNode = path_node_packed.instantiate()
		path_node.position.x = x
		path_node.position.y = y
		path_node_handler.add_child(path_node)
		path_node_handler.add_path_node(path_node)
	
