extends Node
class_name GuardSM

enum States {IDLE, CHASE, RETREIVE, RETURN}
var currentstate = States.IDLE
@onready var label = $"../StateLabel"

func _ready() -> void:
	GuardSignal.guardCommand.connect(set_state)

func set_state(newState):
	if newState is States:
		currentstate = newState
		label.text = str(currentstate)
	pass


func _on_interact_ray_can() -> void:
	set_state(States.RETURN)
	pass # Replace with function body.

func _on_interact_ray_home() -> void:
	set_state(States.IDLE)
	pass # Replace with function body.
