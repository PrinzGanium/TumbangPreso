extends CSGBox3D

signal foundPlayer(player)
signal forgotPlayer(player)


func _on_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		body.stats.tag()
		emit_signal("foundPlayer", body)
	pass # Replace with function body.


func _on_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("tapon"):
		body.stats.untag()
	pass # Replace with function body.
