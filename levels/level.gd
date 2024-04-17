extends Node2D
class_name Level

@onready var player: Player = $Player

@export var max_player_score: int = 1000

## Returns the progress of the level in range [0, 1]
func get_progress_normalized() -> float:
	return clampf(float(player.score) / float(max_player_score), 0.0, 1.0)
