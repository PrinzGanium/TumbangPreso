extends NavigationRegion3D

func _on_bake_finished() -> void:
	GuardSignal.emit_signal("mapReady")
	pass # Replace with function body.
