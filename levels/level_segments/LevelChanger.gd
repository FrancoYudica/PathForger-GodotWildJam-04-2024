extends Node
class_name LevelChanger

## Ranges from [0, 1]
@export var dynamic_difficulty = 0.0

## Maximum value used. A value of 1 says that
## the LevelChanger part can't be harder than
## the starting part.
@export var max_difficulty_value = 2.0

## Ranges in [1, max_difficulty_value]
var difficulty: float:
	get:
		return 1.0 + dynamic_difficulty * (max_difficulty_value - 1.0)
