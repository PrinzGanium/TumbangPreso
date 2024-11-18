extends CSGBox3D

var active = false

var can_object = load("res://MenuNavigation/Games/TumbangPreso/Can/can_game_object.tscn")
var instance
# should activate in

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("can"):
		print("he ran!")
		active = true
	pass # Replace with function body.

func _process(delta: float) -> void:
	$Can.visible = active
	
	if Input.is_action_just_pressed("leftclick"):
		reset()

func reset():
	instance = can_object.instantiate()
	instance.global_position = $SpawnPoint.global_position
	add_child(instance)
	
