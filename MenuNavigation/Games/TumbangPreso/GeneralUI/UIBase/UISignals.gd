extends CanvasLayer

@export var time = 30
var points = 0
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	$Time.start(time)
	GuardSignal.playerCaught.connect(LoseGame)
	GuardSignal.canHit.connect(updatePoints)
	pass # Replace with function body.

func LoseGame() -> void:
	$WinLose.text = "NAHULI KITA!"
	$WinLose.show()
	pass

func updatePoints():
	points += 1
	$Points.text = str(points) + "!"
	pass

func _on_game_timer_timeout() -> void:
	get_tree().quit()
	pass # Replace with function body.
