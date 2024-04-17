extends Path2D


@export var rotation_offset = 90
@export var negative_rotation: bool = false

func _ready():
	var offset = rotation_offset * randi_range(-1 if negative_rotation else 0, 1)
	rotation_degrees += offset
