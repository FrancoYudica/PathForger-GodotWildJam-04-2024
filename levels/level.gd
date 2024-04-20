extends Node2D
class_name Level

@onready var player: Player = $Player
@onready var camera := $MainCamera
@onready var menu_phantom_camera: PhantomCamera2D = $StartPhantomCamera2D2
@onready var pressure_spikes = $PressureSpikes
@onready var state_machine: StateMachine = $LevelStateMachine
@onready var level_builder := $LevelBuilder

@export var max_player_score: int = 1000
@export var score_data: ScoreData

var player_highscore = 0

## Returns the progress of the level in range [0, 1]
func get_progress_normalized() -> float:
	return clampf(float(player.score) / float(max_player_score), 0.0, 1.0)

func _ready():
	state_machine.initialize()

func _exit_tree():
	ResourceSaver.save(score_data)

func _on_player_death():
	
	# Updates score data
	score_data.last_score = player.score
	score_data.deaths += 1
	score_data.total += player.score
	
	if score_data.last_score > score_data.best:
		score_data.best = score_data.last_score
	
