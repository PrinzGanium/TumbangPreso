extends Node3D

var available = false

@onready var can = $Can

func reset():
	can.sleeping = true
	can.global_rotation = Vector3.ZERO
	can.position = Vector3(0,0,0)
	can.sleeping = false
	show()
	pass


func _on_can_body_entered(body: Node) -> void:
	if body.is_in_group("Tsinelas"):
		print("got hit!")
		GuardSignal.emit_signal("canHit")
		
	pass # Replace with function body.


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("area: ", area)
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("ground"):
		print("knocked over!")
		GuardSignal.emit_signal("guardCommand", GuardSM.States.RETREIVE)
		available = true
	pass # Replace with function body.


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("playarea"):
		print("left area")
		GuardSignal.emit_signal("guardCommand", GuardSM.States.RETREIVE)
		available = true
	pass # Replace with function body.
