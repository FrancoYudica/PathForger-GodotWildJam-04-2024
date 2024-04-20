@icon("res://art/textures/icons/classes/FSMSprite.png")
extends Node2D
class_name StateMachine

@export var initial_state_name : String
var _current_state : StateMachineNode = null
var _states = {}
var _states_names_stack : Array[String] = []

## Initializes and loads all StateMachineNode children.
## Calling this is requiered
func initialize():
	
	# Adds all States
	for child in get_children():
		add(child)
	
	if initial_state_name not in _states:
		push_error("StateMachine doesn't have a state named: %s" % initial_state_name)
		return
	
	# Sets initial state
	_set_current_state(_states[initial_state_name])
	_states_names_stack.append(initial_state_name)

## Adds state to StateMachine
func add(state: StateMachineNode):
	if not (state is StateMachineNode):
		push_error("All children of StateMachine should be StateMachineNode")
		return
	
	if state.name in _states:
		assert(false, "States of StateMachine should have diferent names")
	
	state.__set_state_machine(self)
	
	_states[state.name] = state

func erase(state_name: String):
	if not _states.erase(state_name):
		push_error("StateMachine::erase. Coudln't find state named <%s>" % state_name)

func force_transition(state_name: String):
	_current_state.transition(state_name)

func _process(delta):
	_current_state._state_process(delta)
	
func _physics_process(delta):
	_current_state._state_physics_process(delta)
	
func _input(event):
	_current_state._state_input(event)

func _set_current_state(state: StateMachineNode):
	
	if _current_state != null:
		_current_state._state_exit()
	
	_current_state = state
	_current_state._state_enter()
