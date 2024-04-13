## Keeps track of PathNodes and provides functionality to access them
extends Node2D
class_name PathNodeHandler

var path_nodes: Array[PathNode] = []
var on_screen_path_nodes: Array[PathNode] = []

## Returns the narest visible node to a given point
func get_nearest_to_point(point: Vector2) -> PathNode:
	var nearest_node: PathNode = on_screen_path_nodes[0]
	var nearest_d: float = nearest_node.position.distance_squared_to(point)
	
	for i in range(1, on_screen_path_nodes.size()):
		var node: PathNode = on_screen_path_nodes[i]
		var d: float = node.position.distance_squared_to(point)
		if d < nearest_d:
			nearest_d = d
			nearest_node = node
			
	return nearest_node
	
func add_path_node(path_node: PathNode):
	path_node.connect("screen_entered", func (): _path_node_screen_entered(path_node))
	path_node.connect("screen_exited", func (): _path_node_screen_exited(path_node))
	path_nodes.append(path_node)

func _ready():
	for child in get_children():
		
		if child is PathNode:
			add_path_node(child)
		
func _path_node_screen_entered(path_node: PathNode):
	on_screen_path_nodes.append(path_node)
	
func _path_node_screen_exited(path_node: PathNode):
	on_screen_path_nodes.erase(path_node)
