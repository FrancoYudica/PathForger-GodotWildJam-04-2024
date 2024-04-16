extends Node2D
class_name LevelSegment

## Height of the segment. All segments calculate it's height
## and it should only take into consideration the path nodes
## without adding any padding to the segment.
@export var segment_height: int = 0

@export var fix_path_node_heights: bool = true

@export var path_nodes: Array[PathNode]

func calculate_segment_height():
	var top = 0
	var bottom = 0
	for path_node in path_nodes:
		top = minf(path_node.position.y, top)
		bottom = maxf(path_node.position.y, bottom)
		
	segment_height = bottom - top

func add_child_path_node(path_node):
	add_child(path_node)
	path_nodes.append(path_node)

func _ready():
	
	for child in get_children():
		if child is PathNode:
			
			if path_nodes.count(child) == 0:
				path_nodes.append(child)
	
	if fix_path_node_heights:
		for i in range(path_nodes.size()):
			path_nodes[i].position.y = -i * Globals.vertical_gap
			
	calculate_segment_height()
