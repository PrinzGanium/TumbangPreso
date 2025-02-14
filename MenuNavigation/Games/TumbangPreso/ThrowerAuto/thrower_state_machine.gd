extends Node
class_name ThrowerSM

enum States {IDLE, AIM, RETRIEVE, LURE}
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
			_:
				pass
		if p:	
			currentstate = newState
		label.text = str(currentstate)
	pass

func force_state(newState):
	currentstate = newState
	label.text = str(currentstate)

func set_aware(y):
	aware = y
	pass

func deactivate():
	pass
