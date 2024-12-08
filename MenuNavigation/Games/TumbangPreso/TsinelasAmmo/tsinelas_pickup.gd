extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		print("picked up!")
		position = Vector3.DOWN * 10
		body.gain_ammo()
		
		call_deferred("queue_free")
	pass # Replace with function body.
