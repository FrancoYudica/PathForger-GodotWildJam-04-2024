## Holds a list of generators and picks one of them randomly
extends SegmentGenerator

var _generators: Array[SegmentGenerator] = []

func _ready():
	for child in get_children():
		if child is SegmentGenerator:
			_generators.append(child)
	
func generate() -> LevelSegment:
	var generator: SegmentGenerator = _generators.pick_random()
	return generator.generate()
