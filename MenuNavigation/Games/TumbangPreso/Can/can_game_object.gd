extends Node3D

var available = false


func _on_can_body_entered(body: Node) -> void:
	if body.is_in_group("Tsinelas"):
		print("got hit!")
	pass # Replace with function body.


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("area: ", area)
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("ground"):
		print("knocked over!")
		available = true
	pass # Replace with function body.


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("playarea"):
		print("left area")
		available = true
	pass # Replace with function body.