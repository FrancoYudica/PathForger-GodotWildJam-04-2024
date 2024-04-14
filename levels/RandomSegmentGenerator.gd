## Exports LevelSegment scenes and randomly picks one of them when generate is called
extends SegmentGenerator

@export var min_nodes: int = 3
@export var max_nodes: int = 10

@export var packed_level_segments: Array[PackedScene] = []

func generate() -> LevelSegment:
	
	var packed_level_segment: PackedScene = packed_level_segments.pick_random()
	var level_segment = packed_level_segment.instantiate()
	return level_segment
