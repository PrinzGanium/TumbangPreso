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
