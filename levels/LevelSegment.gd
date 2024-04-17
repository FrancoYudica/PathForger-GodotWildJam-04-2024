extends Node2D
class_name LevelSegment

@export_category("Segment height")
@export var manual_segment_height: bool = false
## Height of the segment. All segments calculate it's height
## and it should only take into consideration the path nodes
## without adding any padding to the segment.
@export var segment_height: int = 0

@export var fix_path_node_heights: bool = true

@export var path_nodes: Array[PathNode]

func calculate_segment_height():
	
	if manual_segment_height:
		return
	
	var top = INF
	var bottom = -INF
	for path_node in path_nodes:
		top = minf(path_node.global_position.y, top)
		bottom = maxf(path_node.global_position.y, bottom)
		
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
