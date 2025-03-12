extends Node3D

var canMaterial : StandardMaterial3D = load("res://MenuNavigation/CanEditor/CustomColorCan.tres")

func _on_color_picker_color_changed(color: Color) -> void:
	canMaterial.albedo_color = color
	pass # Replace with function body.


@export_dir var gameScene1
@export_dir var gameScene2

func _on_button_pressed() -> void:
	var c = gameScene1 if randf() <= 0.5 else gameScene2
	get_tree().change_scene_to_file(c)
	pass # Replace with function body.
