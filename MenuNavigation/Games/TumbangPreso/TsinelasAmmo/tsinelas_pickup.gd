extends Node3D

func _ready() -> void:
	print("oops")

func clean_up() -> void:
	call_deferred("queue_free")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		$tsinelas.remove_from_group("pickup")
		print("picked up!")
		body.gain_ammo()
		
		call_deferred("queue_free")
	pass # Replace with function body.
