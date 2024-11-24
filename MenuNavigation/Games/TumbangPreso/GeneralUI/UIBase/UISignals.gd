extends CanvasLayer

@export var time = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Time.start(time)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_timer_timeout() -> void:
	get_tree().quit()
	pass # Replace with function body.
