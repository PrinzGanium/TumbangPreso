extends CanvasLayer

@export_enum("Taya", "Tapon") var ver = "Taya"
@export var time = 30
var points = 0

@onready var GT = $Time/GameTimer
@export_dir var otherScene

@onready var Shouter = $Shouter
# Called when the node enters the scene tree for the first time.


func _ready() -> void:

	if GlobalSignals.passtime:
		time = GlobalSignals.timeleft
		points = GlobalSignals.passScore
	clean_up()
	
	$AnimationPlayer.play("Announcer")
	
	GlobalSignals.playerCaught.connect(LoseGame)
	GlobalSignals.canHit.connect(updatePoints)
	GlobalSignals.ThrowerInArea.connect(throwerInside)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		_on_pause_toggled(true)
		

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
	pass

func swapScene() -> void:
	get_tree().change_scene_to_file(otherScene)
	GlobalSignals.timeleft = GT.time_left
	GlobalSignals.passtime = true
	GlobalSignals.passScore = points

func gameOver() -> void:
	get_tree().change_scene_to_file("res://MenuNavigation/EndMenu/EndMenu.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass

func updatePoints():
	points += 1
	$Time/CenterContainer/TextureRect/Points.text = str(points) + "!"
	Shouter.shout(ver, 1)
	pass

func _on_game_timer_timeout() -> void:
	$AnimationPlayer.play("GameOver")
	$GameOverScreen/Panel/VBoxContainer/Points.text = str(points)
	pass # Replace with function body.

func throwerInside():
	Shouter.shout(ver, 3)
	pass


func _on_pause_toggled(toggled_on: bool) -> void:
	get_tree().paused = true
	$PauseMenu.show()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MenuNavigation/StartMenu/StartMenu.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass # Replace with function body.


func _on_replay_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$PauseMenu.hide()
	pass # Replace with function body.
