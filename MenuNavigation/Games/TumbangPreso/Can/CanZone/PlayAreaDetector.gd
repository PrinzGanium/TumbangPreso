extends Area3D


func interact(picker):
	if picker.stats.hasCan:
		picker.stats.hasCan = false
		owner.active = false
		owner.reset()
	print("bap")
