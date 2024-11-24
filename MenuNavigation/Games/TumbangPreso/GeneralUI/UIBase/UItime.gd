extends Control

func start(time):
	$GameTimer.start(time)

func _process(_delta: float) -> void:
	$Timer.text = str(round($GameTimer.time_left))
