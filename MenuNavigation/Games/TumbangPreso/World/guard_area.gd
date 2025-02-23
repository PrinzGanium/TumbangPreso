extends CSGBox3D

func _on_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		GlobalSignals.emit_signal("ThrowerInArea")
		GlobalSignals.emit_signal("guardCommand", GuardSM.States.CHASE)
		#body.stats.tag()
		#GlobalSignals.emit_signal("playerAware", true)
		


func _on_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		GlobalSignals.emit_signal("ThrowerOutArea")
		GlobalSignals.emit_signal("guardCommand", GuardSM.States.IDLE)
		#body.stats.untag()
		#GlobalSignals.emit_signal("playerAware", false)
		
