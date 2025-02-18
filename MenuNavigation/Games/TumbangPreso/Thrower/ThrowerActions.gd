extends Node

@onready var stats = $"../PlayerStats"
@onready var weapon = $"../Head/Camera3D/Thrower"
@onready var timer = $Timer

func add_ammo():
	stats.ammo += 1
	hide_tsinelas(stats.ammo)

func _input(event: InputEvent) -> void:
	if event and Input.is_action_just_pressed("leftclick") and stats.ammo > 0:
		timer.start()
	if event and Input.is_action_just_released("leftclick") and stats.ammo > 0:
		var t = 1 - timer.time_left
		print(t)
		weapon.throw(t)
		stats.ammo -= 1
		hide_tsinelas(bool(stats.ammo))

func _process(_delta: float) -> void:
	$"../Head/Camera3D/Thrower/HUD/ChargeBar".value = 100 * (1 - timer.time_left)
	
func hide_tsinelas(t : bool):
	$"../Head/Camera3D/tsinelas".visible = t
	$"../Head/Camera3D/Thrower/HUD/ChargeBar".visible = t
	pass
