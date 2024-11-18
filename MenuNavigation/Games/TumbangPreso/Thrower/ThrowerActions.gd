extends Node

@onready var stats = $"../PlayerStats"
@onready var weapon = $"../Head/Camera3D/Thrower"

func _input(event: InputEvent) -> void:
	if event and Input.is_action_just_pressed("leftclick") and stats.ammo > 0:
		weapon.throw()
		stats.ammo -= 1
