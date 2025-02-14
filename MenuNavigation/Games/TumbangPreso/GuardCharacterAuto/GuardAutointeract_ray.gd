extends RayCast3D

signal can
signal home
signal playerCaught


@export var auto = false
@onready var SM = $"../../../GuardStateMachine"
@onready var stats = $"../../../PlayerStats"
@onready var prompt = $Prompt

var caught = false


func _process(_delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		prompt.text  = "detecting " + collider.name
		
		
		if collider.is_in_group("can") and SM.currentstate == GuardSM.States.RETREIVE:
			collider.interact(self)
			emit_signal("can")
		
		if collider.is_in_group("playarea") and SM.currentstate == GuardSM.States.RETURN:
			collider.interact(self)
			emit_signal("home")
		
		if collider.is_in_group("tapon") and not caught:
			caught = true
			print("caught")
			GuardSignal.emit_signal("playerCaught")
