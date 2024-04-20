extends Node2D

@onready var first_path_node: PathNode = $FirstPathNode
@onready var level_generator: SegmentGenerator = $GeneratorPicker
@onready var camera = $"../MainCamera"

@export var viewport_height = 960
@export var dynamic_difficulty_curve: Curve

## Generates a new segment when the camera is 'edge_height' from the generated map _top_position
@export var edge_height: int = 300
var _top_position: Vector2 = Vector2.ZERO

var _segments: Array[LevelSegment] = []

func _ready():
	_top_position = first_path_node.position
	_top_position.y -= Globals.vertical_gap
	
func _process(_delta):
	
	# When it's time to generate a new segment
	if camera.position.y - viewport_height / 2 - _top_position.y < edge_height:
		_add_random_segment()
		
	_try_remove_traversed_segments()

func _add_random_segment():
	var level_segment = level_generator.generate()
	_add_segment(level_segment)

func _add_segment(segment: LevelSegment):
	add_child(segment)
	segment.position = _top_position
	_top_position.y -= segment.segment_height + Globals.vertical_gap
	_segments.append(segment)

## Tries to remove all the traversed/completed invisible segments
func _try_remove_traversed_segments():
	
	# Valued used to ensure that the deletion of the segment isn't visible
	var _extra_safety_height = 300
	
	for segment: LevelSegment in _segments:
		
		# Tests visibility for all segments
		var segment_top = segment.global_position.y - segment.segment_height - _extra_safety_height
		if segment_top > camera.position.y + viewport_height / 2:
			
			# Removes segment when not visible
			_segments.erase(segment)
			remove_child(segment)
