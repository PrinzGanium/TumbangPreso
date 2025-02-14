extends CanvasLayer

@export var time = 30
var points = 0

@onready var MControls = $"Controls" 

@export_dir var otherScene

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	#if Settings.mode == Settings.modes.MOBILE:
		#MControls.show()
	#else:
		#MControls.hide()
	clean_up()
	
	
	$AnimationPlayer.play("Announcer")
	
	GuardSignal.playerCaught.connect(LoseGame)
	GuardSignal.canHit.connect(updatePoints)
	pass # Replace with function body.

func clean_up() -> void:
	var z = []
	z.append_array(get_tree().get_nodes_in_group("cleanup"))
	for t in z:
		t.clean_up()
	pass

func startTimer():
	$Time.start(time)
	pass

func LoseGame() -> void:
	$AnimationPlayer.play("Transfer")
	$WinLose.text = "NAHULI KITA!"
	$WinLose.show()
	pass

func swapScene() -> void:
	get_tree().change_scene_to_file(otherScene)

func updatePoints():
	points += 1
	$Points.text = str(points) + "!"
	pass

func _on_game_timer_timeout() -> void:
	get_tree().quit()
	pass # Replace with function body.
