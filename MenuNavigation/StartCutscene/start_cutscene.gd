extends Control

var current_frame = 0

func _ready() -> void:
	$AnimationPlayer.play("Fader")

func _on_button_pressed() -> void:
	current_frame += 1
	if current_frame >= 4:
		$AnimationPlayer.play("Fadeout")
		return
	
	$Control/AnimatedSprite2D.frame = current_frame
	pass # Replace with function body.

func next_scene() -> void:
	get_tree().change_scene_to_file("res://MenuNavigation/StartMenu/StartMenu.tscn")
	pass
