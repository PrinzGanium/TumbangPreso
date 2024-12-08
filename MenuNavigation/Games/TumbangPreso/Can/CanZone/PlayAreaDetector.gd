extends Area3D


func interact(picker):
	print("picked")
	if picker.stats.hasCan:
		picker.stats.hasCan = false
		owner.active = false
		owner.reset()
