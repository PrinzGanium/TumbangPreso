extends Node

@onready var stats = $"../PlayerStats"
@onready var weapon = $"../Head/Camera3D/Thrower"
@onready var timer = $Timer

@onready var tmod1 = $"../Head/Camera3D/tsinelas"
@onready var tmod2 = $"../Head/Camera3D/tsinelas2"


func add_ammo():
	stats.ammo += 1
	hide_tsinelas(stats.ammo)

func _input(event: InputEvent) -> void:
	if Settings.mode == Settings.modes.COMP:
		if event and Input.is_action_just_pressed("leftclick") and stats.ammo > 0:
			timer.start()
		if event and Input.is_action_just_released("leftclick") and stats.ammo > 0:
			var t = 1 - timer.time_left
			print(t)
			weapon.throw(t)
			stats.ammo -= 1
			hide_tsinelas(stats.ammo)

func _process(_delta: float) -> void:
	$"../Head/Camera3D/HUD/ChargeBar".value = 100 * (1 - timer.time_left)
	
func hide_tsinelas(t : int):
	if t>=2:
		tmod1.show()
		tmod2.show()
	if t==1:
		if randf() < 0.5:
			tmod1.hide()
			tmod2.show()
	if randf() < 0.5:
			tmod2.hide()
			tmod1.show()
	if t<=0:
		tmod1.hide()
		tmod2.hide()
	pass


func _on_action_button_pressed() -> void:
	if stats.ammo > 0:
		var t = 1 - timer.time_left
		print(t)
		weapon.throw(t)
		stats.ammo -= 1
		hide_tsinelas(bool(stats.ammo))
	pass # Replace with function body.
