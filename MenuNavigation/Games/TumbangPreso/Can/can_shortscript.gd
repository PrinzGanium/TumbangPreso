extends RigidBody3D


func interact(picker) -> bool:
	if owner.available:
		print("available")
		sleeping = true
		global_position = Vector3(0, -10, 0)
		picker.stats.hasCan = true
		return true
	print("not available")
	return false
	
