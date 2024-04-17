extends Path2D

@export var level_changer: LevelChanger
@export var start_move_when_reached = false
@onready var path_follow = $PathFollow2D

func _ready():
	path_follow.level_changer = level_changer
	path_follow.start_move_when_reached = start_move_when_reached
