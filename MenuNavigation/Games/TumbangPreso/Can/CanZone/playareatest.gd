extends CSGCylinder3D

var active = false
@onready var can = $CanGameObject

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("can"):
		GuardSignal.emit_signal("guardCommand", GuardSM.States.RETREIVE)
		active = true
	pass # Replace with function body.

func _process(_delta: float) -> void:
	$HoloCan.visible = active

func reset():
	print("RESET?")
	active = false
	can.reset()
	pass
