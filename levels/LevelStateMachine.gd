extends StateMachine

@export var level: Level

func add(state: StateMachineNode):
	super.add(state)
	state.level = level
