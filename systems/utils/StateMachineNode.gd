## State/Node of state machine. 
## StateMachineNode is a class designed to be extended
## and custom behaviour can be added overriding it's 
## undefined methods. Note that the default Node methods
## shouldn't be used.
@icon("res://art/textures/icons/classes/FSMStateSprite.png")
extends Node2D
class_name StateMachineNode

# Holds reference to state machine
var __state_machine : StateMachine

func __set_state_machine(machine: StateMachine):
	__state_machine = machine

func _state_enter():
	pass

func _state_exit():
	pass

func _state_input(_event: InputEvent):
	pass

func _state_process(_delta):
	pass
	
func _state_physics_process(_delta):
	pass

## Travels to given state name
func transition(state_name: String):
	# Changes to new state
	var state = __state_machine._states[state_name]
	__state_machine._set_current_state(state)
	

## Adds state to the stack and travels to that state
func push_transition(state_name: String):
	# Pushes current state and changes to new state
	__state_machine._states_names_stack.push_back(state_name)
	transition(state_name)

## Removes the state from the stack and travels back
func pop_transition():
	if __state_machine._states_names_stack.size() == 0:
		assert(false, "StateMachineNode: Trying to Pop when state stack is empty")
		return
	
	# Removes the last state
	pop_quiet()
	transition_back()

## Travels to the last state in the stack
func transition_back():
	var previous_state_name = __state_machine._states_names_stack.back()
	transition(previous_state_name)

## Removes the state from the stack. It doesn't execute any transition
func pop_quiet():
	var last_state = __state_machine._states_names_stack.pop_back()
	if last_state != name:
		assert(false, "Using pop_quiet when state: %s wasn't pushed!" % name)
		

## Returns state machine
func get_machine() -> StateMachine:
	return __state_machine
	
func is_active():
	return __state_machine._current_state.name == name
