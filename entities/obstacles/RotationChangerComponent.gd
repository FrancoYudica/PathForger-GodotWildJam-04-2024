extends Node2D
class_name RotationChangerComponent
@export var level_changer: LevelChanger
@export var rotations_per_second: float = 0.3
@export var phase_offset: float = 0.0

func _ready():
	get_parent().rotation += phase_offset

func _process(delta):
	get_parent().rotation += 2.0 * PI * delta * rotations_per_second * level_changer.difficulty
