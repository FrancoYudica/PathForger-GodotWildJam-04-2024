extends Node2D
class_name Player

signal death
signal hooked_something()
signal spawned

@onready var line_path: Line2D = $LinePath
@onready var sprite = $PlayerSprite
@onready var hook: Hook = $Hook
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var raycast: PlayerRaycast = $PlayerRayCast2D
@onready var hitbox_area = $CollisionArea2D

@export var click_buffering_ms: int = 300
@export var score: int = 0
@export var start_path_node: PathNode

var current_hookable: Hookable = null
var last_buffered_time_ms = 0
var direction: Vector2 = Vector2.UP
var stick_to_hookable: bool = true

var _packed_spawn_vfx = load("res://entities/vfx/player_spawn_vfx.tscn")

func respawn():
	
	# Sets position to spawn point
	global_position = start_path_node.global_position
	line_path.clear_points()
	line_path.add_point(position)
	
	# Spawn VFX
	var spawn_vfx: VFX = _packed_spawn_vfx.instantiate()
	spawn_vfx.global_position = global_position
	get_parent().add_child(spawn_vfx)
	spawn_vfx.begin()
	await spawn_vfx.finished
	
	hook.hide()
	sprite.show()
	
	# Reset hookable and hitbox mask
	current_hookable = null
	hitbox_area.collision_mask = 16
	
	# Scales player to it's size
	sprite.scale = Vector2.ZERO
	create_tween().tween_property(sprite, "scale", Vector2.ONE, 0.1)
	
	spawned.emit()
	
	state_machine.force_transition("idle")
	
func set_current_hookable(hookable: Hookable):
	if current_hookable != null:
		current_hookable.left()
	current_hookable = hookable
	if current_hookable != null:
		hooked_something.emit()

func death_by_obstacle():
	death.emit()
	hitbox_area.collision_mask = 0

func _ready():
	line_path.add_point(position)
	state_machine.initialize()
	hook.global_position = global_position

func _process(delta):
	
	# Last point position in player
	line_path.set_point_position(line_path.points.size() - 1, position)

func _physics_process(delta):
	if current_hookable != null and stick_to_hookable and current_hookable.has_player_over:
		global_position = current_hookable.get_intersection_point()


func _on_collision_area_2d_area_entered(area):
	state_machine.force_transition("death")
	death_by_obstacle()
