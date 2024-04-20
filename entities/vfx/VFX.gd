extends Node2D
class_name VFX

signal finished

func begin():
	pass
	
	
func end():
	finished.emit()
	queue_free()
