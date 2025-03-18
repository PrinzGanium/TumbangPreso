extends Control

#Navigations
@export var gameSelectScene: PackedScene
@export_dir var endscreen


func _on_Start_pressed():
	
	get_tree().change_scene_to_packed(gameSelectScene)
	pass # Replace with function body.


func _on_Credits_pressed():
	get_tree().change_scene_to_file(endscreen)
	pass # Replace with function body.


func _on_mobile_toggled(toggled_on: bool) -> void:
	$TextureRect/VBoxContainer/Mobile.text = "MOBILE" if toggled_on else "COMP"
	Settings.mode = Settings.modes.MOBILE if toggled_on else Settings.modes.COMP
	Input.emulate_mouse_from_touch = toggled_on
	Input.emulate_touch_from_mouse = not toggled_on
	pass # Replace with function body.
