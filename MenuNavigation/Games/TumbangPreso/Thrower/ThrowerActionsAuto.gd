extends Node

@onready var stats = $"../PlayerStats"
@onready var weapon = $"../Head/Camera3D/Thrower"
@onready var timer = $Timer
@onready var SM = $"../ThrowerStateMachine"


func add_ammo():
	stats.ammo += 1
	#hide_tsinelas(stats.ammo)


func _on_timer_timeout() -> void:
	# throw when can active
	if stats.ammo > 0 and SM.currentstate == SM.States.IDLE and $"..".canThrow:
		weapon.throw(1)
		stats.ammo -= 1
		timer.wait_time = randf_range(1.0, 3.0)
		timer.start()
	else:
		pass
	pass # Replace with function body.
