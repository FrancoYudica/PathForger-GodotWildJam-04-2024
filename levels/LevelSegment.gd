extends Node2D
class_name LevelSegment

@export_enum("Easy", "Medium", "Hard", "Ultra") var difficulty_enum_index = 0

@onready var level_changer: LevelChanger = $LevelChanger
@onready var bottom_marker = $BottomMarker2D
@onready var top_marker = $TopMarker2D

## Static difficulty mapped in range [0, 1]
var static_difficulty: float = 0.0

## Height of the segment. All segments calculate it's height
## and it should only take into consideration the path nodes
## without adding any padding to the segment.
var segment_height: float = 0.0

var dynamic_difficulty: float = 0.0

func _ready():
	# Maps difficulty to range [0, 1]
	static_difficulty = float(difficulty_enum_index) / 4.0
	
	# Calculates segment height with markers
	segment_height = absf(top_marker.position.y - bottom_marker.position.y)
	
	level_changer.dynamic_difficulty = dynamic_difficulty
	
