extends CSGBox3D

func _on_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		body.stats.tag()
		GuardSignal.emit_signal("playerAware", true)
		GuardSignal.emit_signal("guardCommand", GuardSM.States.CHASE)
		
	pass


func _on_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		body.stats.untag()
		GuardSignal.emit_signal("playerAware", false)
		GuardSignal.emit_signal("guardCommand", GuardSM.States.IDLE)
		
	pass
