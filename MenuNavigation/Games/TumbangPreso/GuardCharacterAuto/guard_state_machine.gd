extends Node

enum {IDLE, CHASE, RETREIVE, RETURN}
var currentstate = IDLE
@onready var label = $"../StateLabel"

func _ready() -> void:
	set_state("IDLE")

func set_state(newState):
	match newState:
		"IDLE":		currentstate = IDLE
		"CHASE":	currentstate = CHASE
		"RETRIEVE":	currentstate = RETREIVE
		"RETURN":	currentstate = RETURN
	
	label.text = str(currentstate)
	pass
