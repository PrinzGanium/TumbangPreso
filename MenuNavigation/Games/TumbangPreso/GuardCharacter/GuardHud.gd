extends Control

func _ready() -> void:
	if Settings.mode == Settings.modes.MOBILE:
		$Controls.show()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$Controls.hide()
