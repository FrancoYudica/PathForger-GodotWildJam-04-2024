extends LevelSegment

@export var min_nodes: int = 3
@export var max_nodes: int = 10

var path_node_packed = preload("res://entities/path_node/path_node.tscn")

func _ready():
	
	var n = randi_range(min_nodes, max_nodes)
	
	for i in range(n):
		var x = randf_range(-Globals.gameplay_width * 0.5, Globals.gameplay_width * 0.5)
		var path_node: PathNode = path_node_packed.instantiate()
		path_node.position.x = x
		add_child_path_node(path_node)
		
	super._ready()
