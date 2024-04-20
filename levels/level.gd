extends Node2D
class_name Level

@onready var player: Player = $Player
@onready var camera := $MainCamera
@onready var menu_phantom_camera: PhantomCamera2D = $StartPhantomCamera2D2
@onready var pressure_spikes = $PressureSpikes
@onready var state_machine: StateMachine = $LevelStateMachine
@onready var level_builder := $LevelBuilder

@export var max_player_score: int = 1000

## Returns the progress of the level in range [0, 1]
func get_progress_normalized() -> float:
	return clampf(float(player.score) / float(max_player_score), 0.0, 1.0)

func _ready():
	state_machine.initialize()
