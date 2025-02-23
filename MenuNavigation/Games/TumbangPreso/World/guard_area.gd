extends CSGBox3D

func _on_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		pass
		#body.stats.tag()
		#GlobalSignals.emit_signal("playerAware", true)
		#GlobalSignals.emit_signal("guardCommand", GuardSM.States.CHASE)
		
		#GlobalSignals.emit_signal("ThrowerInArea")
		
	pass


func _on_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		pass
		#body.stats.untag()
		#GlobalSignals.emit_signal("playerAware", false)
		#GlobalSignals.emit_signal("guardCommand", GuardSM.States.IDLE)
		
		#GlobalSignals.emit_signal("ThrowerOutArea")
	pass
