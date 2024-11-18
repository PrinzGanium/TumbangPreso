extends RigidBody3D


func interact(picker) -> bool:
	print("pickmeupppp")
	if owner.available:
		print("available")
		hide()
		
		picker.stats.hasCan = true
		return true
	print("not available")
	return false
	
func reset():
	print("nothing yet")
