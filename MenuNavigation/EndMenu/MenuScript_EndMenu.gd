extends Control

@export_dir var homescreen

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Return_pressed():
	get_tree().change_scene_to_file(homescreen)
	pass # Replace with function body.
