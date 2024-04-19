## Exports LevelSegment scenes and randomly picks one of them when generate is called
extends SegmentGenerator

@export var _level: Level
@export var _dynamic_difficulty_curve: Curve
@export var packed_easy_segments: Array[PackedScene] = []
@export var packed_medium_segments: Array[PackedScene] = []
@export var packed_hard_segments: Array[PackedScene] = []
@export var packed_ultra_segments: Array[PackedScene] = []


var _DIFFICULTY_TYPES_COUNT = 3

func generate() -> LevelSegment:
	
	# Adds random offset to progress
	var progress_offset = (randf() * 2.0 - 1.0) / _DIFFICULTY_TYPES_COUNT
	
	# Calculates progress as a combination of current level progress and the offset
	var current_level_progress = _level.get_progress_normalized()
	var progress = clampf(current_level_progress + progress_offset, 0.0, 1.0)
	
	# Maps progress to [0, 1, 2, ..., _DIFFICULTY_TYPES_COUNT - 1]
	var indexed_progress = clamp(
		floori(progress * (_DIFFICULTY_TYPES_COUNT)),
		0,
		_DIFFICULTY_TYPES_COUNT - 1
	)
	# If _DIFFICULTY_TYPES_COUNT == 3, [0.00, 0.25, 0.50, 0.75]
	var normalized_index = float(indexed_progress) / _DIFFICULTY_TYPES_COUNT
	
	# Difficulty is calculated as the distance from the current progress to the difficulty type floating index -> [0.0, 1.0]
	var dynamic_difficulty: float = (progress - normalized_index) * _DIFFICULTY_TYPES_COUNT
	#print(str(indexed_progress) + "dynamic: %s" % dynamic_difficulty)
	
	# Gets random level segment and instantiates
	var packed_level_segment: PackedScene = _get_packed_scene_by_difficulty(indexed_progress)
	var level_segment = packed_level_segment.instantiate()
	
	# Sets dynamic difficulty sampled from the curve
	level_segment.dynamic_difficulty = _dynamic_difficulty_curve.sample(dynamic_difficulty)
	return level_segment

func _get_packed_scene_by_difficulty(difficulty_index: int) -> PackedScene:
	match difficulty_index:
		0:
			return packed_easy_segments.pick_random()
		1:
			return packed_medium_segments.pick_random()
		2:
			return packed_hard_segments.pick_random()
		3:
			return packed_ultra_segments.pick_random()
			
		_:
			assert(false, "Unimplemented difficulty")
			return null
