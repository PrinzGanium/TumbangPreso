extends Control
var total = 0

@onready var timer = $GameTimer
@onready var progressbar = $CenterContainer/TextureRect/TextureProgressBar
@onready var timertext = $CenterContainer/TextureRect/Timer

func start(time):
	timer.start(time)
	total = time

func _process(_delta: float) -> void:
	timertext.text = str(round(timer.time_left))
	progressbar.value = ((total - timer.time_left)/total) * 100
	print(progressbar.value)
