extends Control

#Navigation
@export var TumbangPreso: PackedScene
@export var Shato: PackedScene
@export var Patintero: PackedScene

@export var TumbangPresoEdit: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene_to_packed(TumbangPreso)
	pass # Replace with function body.


func _on_tumbang_preso_edit_button_down() -> void:
	get_tree().change_scene_to_packed(TumbangPresoEdit)
	pass # Replace with function body.


func _on_patintero_pressed() -> void:
	get_tree().change_scene_to_packed(Patintero)
	pass # Replace with function body.


func _on_shato_pressed() -> void:
	get_tree().change_scene_to_packed(Shato)
	pass # Replace with function body.
