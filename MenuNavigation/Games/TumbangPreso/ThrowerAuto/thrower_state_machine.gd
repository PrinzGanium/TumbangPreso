extends Node
class_name ThrowerSM

enum States {IDLE, RETRIEVE, LURE, FLEE}
var currentstate = States.IDLE
var holdState = States.IDLE

var aware = false

@onready var label = $"../StateLabel"
@onready var timer = $"StateTimer"
@onready var weapon = $"../Head/Camera3D/Thrower"
@onready var stats  = $"../PlayerStats"

func _ready() -> void:
	GuardSignal.guardCommand.connect(set_state)
	GuardSignal.playerAware.connect(set_aware)

func set_state(newState):
	var p = false
	
	if newState is States:
		match currentstate:
			States.IDLE:
				p = true
			States.LURE:
				p = true
			States.RETRIEVE:
				match newState:
					States.FLEE:	p = true
					States.RETRIEVE:	p = true
			States.FLEE:
				match newState:
					States.IDLE:
						p = true
					States.RETRIEVE:
						p = true
			_:
				pass
		if p:	
			currentstate = newState
	pass

func _process(_delta: float) -> void:
	match_label()

func match_label():
	match currentstate:
		States.IDLE:		label.text = str("IDLE")
		States.RETRIEVE:	label.text = str("RETRIEVE")
		States.LURE:		label.text = str("LURE")
		States.FLEE:		label.text = str("FLEE")

func force_state(newState):
	currentstate = newState
	label.text = str(currentstate)

func set_aware(y):
	aware = y
	pass

func deactivate():
	pass


func _on_state_timer_timeout() -> void:
	set_state(States.IDLE)
	pass # Replace with function body.


func _on_player_stats_ammochange() -> void:
	var p = stats.ammo/3
	if randf() < p:
		set_state(States.RETRIEVE)
	else:
		set_state(States.IDLE) 
	pass # Replace with function body.
