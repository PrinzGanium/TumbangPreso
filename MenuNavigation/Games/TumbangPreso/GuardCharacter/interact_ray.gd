extends RayCast3D

@onready var stats = $"../../../PlayerStats"
@onready var prompt = $Prompt

func _process(_delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		prompt.text  = "detecting " + collider.name
	
		if collider.is_in_group("can") or collider.is_in_group("playarea"):
			if Input.is_action_just_pressed("leftclick"):
				collider.interact(self)
