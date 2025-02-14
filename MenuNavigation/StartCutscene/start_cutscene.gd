extends Control

var current_frame = 0
@export var totalframes = 4
@export var TumbangPreso1: PackedScene
@export var TumbangPreso2: PackedScene

func _ready() -> void:
	$AnimationPlayer.play("Fader")

func _on_button_pressed() -> void:
	current_frame += 1
	if current_frame >= totalframes:
		$AnimationPlayer.play("Fadeout")
		return
	
	$Control/AnimatedSprite2D.frame = current_frame
	pass # Replace with function body.

func next_scene() -> void:
	if randi() < 0.5:
		get_tree().change_scene_to_packed(TumbangPreso1)	#taya!
	else:
		get_tree().change_scene_to_packed(TumbangPreso2)	#tagatapon!
	pass


func _on_skip_button_pressed() -> void:
	next_scene()
	pass # Replace with function body.
