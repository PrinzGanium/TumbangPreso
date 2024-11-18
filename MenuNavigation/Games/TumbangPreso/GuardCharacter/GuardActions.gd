extends Node

@onready var stats = $"../PlayerStats"

func _input(event: InputEvent) -> void:
	if event and Input.is_action_just_pressed("leftclick"):
		#pickup can?
		#place can?
		pass


func _process(delta: float) -> void:
	if stats.hasCan:
		print("BAP")
