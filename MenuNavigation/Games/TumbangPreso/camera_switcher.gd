extends Node

@export var player : CharacterBody3D
@export var guard : CharacterBody3D
var cameras = []
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cameras.append(player.get_node("Head/Camera3D"))
	cameras.append(guard.get_node("Head/Camera3D"))
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("c"):
		index += 1
		index %= cameras.size()
		cameras[index].current = true
