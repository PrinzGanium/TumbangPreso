extends Node
class_name ThrowerSM

enum States {IDLE, WAIT, RETRIEVE, LURE, FLEE}
var currentstate = States.IDLE
var nextState = States.IDLE

var aware = false
var can = true

@onready var label = $"../StateLabel"
@onready var timer = $"StateTimer"
@onready var weapon = $"../Head/Camera3D/Thrower"
@onready var stats  = $"../PlayerStats"

func _ready() -> void:
	GlobalSignals.playerAware.connect(set_aware)
	GlobalSignals.canTake.connect(canTake)
	GlobalSignals.canDown.connect(canTake)
	GlobalSignals.canReturn.connect(canBack)

func set_state(newState):
	var p = false
	
	if newState is States:
		match currentstate:
			States.IDLE:
				p = true
			States.LURE:
				p = true
			States.WAIT:
				p = true
			States.RETRIEVE:
				match newState:
					States.IDLE:
						p = true
					States.LURE:
						p = true
					States.WAIT:
						p = true
					States.FLEE:
						p = true
			States.WAIT:
				if newState == States.IDLE:
					p = true
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
		if currentstate == States.IDLE or currentstate == States.FLEE or currentstate == States.WAIT:
			timer.start()
		else:
			timer.stop()
	pass

func _process(_delta: float) -> void:
	match_label()

func match_label():
	match currentstate:
		States.IDLE:		label.text = str("IDLE")
		States.RETRIEVE:	label.text = str("RETRIEVE")
		States.LURE:		label.text = str("LURE")
		States.FLEE:		label.text = str("FLEE")
		States.WAIT:		label.text = str("WAIT")

func force_state(newState):
	currentstate = newState
	label.text = str(currentstate)

func set_aware(y):
	aware = y
	pass

func deactivate():
	pass

func in_area():
	pass

func canTake():
	can = false
	if stats.ammo < 3:
		force_state(States.RETRIEVE)
	else:
		force_state(States.WAIT)
	pass

func canBack():
	can = true
	force_state(States.IDLE)
	pass

func _on_state_timer_timeout() -> void:
	_on_player_stats_ammochange()
	pass # Replace with function body.


func _on_player_stats_ammochange() -> void:
	# Force state on boundaries
	var nState
	if stats.ammo >= 1 :
		nState = States.IDLE 
	elif stats.ammo <= 0:
		nState = States.RETRIEVE

	#If can is not present, choose actions differently.
	if not can:
		if stats.ammo < 3:
			nState = States.RETRIEVE
		else:
			nState = States.WAIT
	set_state(nState)
	pass # Replace with function body.

# we want to wait till he retrieves the thing so he doesnt bounce around.
