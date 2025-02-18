extends RayCast3D

signal can
signal home
signal playerCaught


@export var auto = false
@onready var stats = $"../../../PlayerStats"
@onready var prompt = $Prompt

func _process(_delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		prompt.text  = "detecting " + collider.name
			
		
		if Input.is_action_just_pressed("leftclick"):
			if collider.is_in_group("can"):
				collider.interact(self)
				emit_signal("can")
			
			if collider.is_in_group("playarea"):
				collider.interact(self)
				emit_signal("home")
			
			if collider.is_in_group("tapon"):
				print("caught")
				GuardSignal.emit_signal("playerCaught")
