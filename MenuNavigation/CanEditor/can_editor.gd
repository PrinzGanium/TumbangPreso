extends Node3D

var canMaterial : StandardMaterial3D = load("res://MenuNavigation/CanEditor/CustomColorCan.tres")

func _on_color_picker_color_changed(color: Color) -> void:
	canMaterial.albedo_color = color
	pass # Replace with function body.


@export_dir var gameCutscene

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(gameCutscene)
	pass # Replace with function body.
