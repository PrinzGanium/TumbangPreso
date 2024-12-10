extends Node
class_name GuardSM

enum States {IDLE, CHASE, RETREIVE, RETURN, DONE}
var currentstate = States.IDLE
var holdState = States.IDLE

var aware = false

@onready var label = $"../StateLabel"

func _ready() -> void:
	GuardSignal.guardCommand.connect(set_state)
	GuardSignal.playerAware.connect(set_aware)

func set_state(newState):
	var p = false
	if newState is States:
		match currentstate:
			States.IDLE:
				match newState:
					States.CHASE:
						p = true
					States.RETREIVE:
						p = true
			States.CHASE:
				match newState:
					States.IDLE:
						p = true
					States.RETREIVE:
						p = true
			States.RETREIVE:
				match newState:
					States.RETURN:
						p = true
			States.RETURN:
				match newState:
					States.DONE:
						p = true
			States.DONE:
				if aware:
					newState = States.CHASE
					p = true
				else:
					newState = States.IDLE
					p = true
					
		
		if p:	
			currentstate = newState
		label.text = str(currentstate)
	pass

func force_state(newState):
	currentstate = newState
	label.text = str(currentstate)

func _on_interact_ray_can() -> void:
	set_state(States.RETURN)
	pass # Replace with function body.

func _on_interact_ray_home() -> void:
	set_state(States.DONE)
	pass # Replace with function body.

func set_aware(y):
	aware = y
	pass
