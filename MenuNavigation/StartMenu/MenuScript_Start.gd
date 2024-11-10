extends Control

#Navigations
@export var gameSelectScene: PackedScene




func _on_Start_pressed():
	get_tree().change_scene_to_packed(gameSelectScene)
	pass # Replace with function body.


func _on_Credits_pressed():
	pass # Replace with function body.
