extends Control

#Navigation
@export var TumbangPreso: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene_to_packed(TumbangPreso)
	pass # Replace with function body.
