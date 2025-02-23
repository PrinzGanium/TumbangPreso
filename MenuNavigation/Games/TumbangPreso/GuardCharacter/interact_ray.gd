extends RayCast3D

signal can
signal home
signal playerCaught


@export var auto = false
@onready var stats = $"../../../PlayerStats"
@onready var prompt = $Prompt

var holdCan = false
@onready var canModel = $"../Can"
func ignore():
	can.emit()
	home.emit()
	playerCaught.emit()

func _process(_delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		prompt.text  = "detecting " + collider.name
			
		
		if true:
			if collider.is_in_group("can"):
				var s = collider.interact(self)
				if s:
					emit_signal("can")
					holdCan = true
					canModel.show()
					GlobalSignals.canTake.emit()
			
			if collider.is_in_group("playarea"):
				var s = collider.interact(self)
				if s:
					holdCan = false
					canModel.hide()
					emit_signal("home")
			
			if collider.is_in_group("tapon"):
				if collider.catchable:
					print("can catch!")
					if not holdCan:
						print("no can!")					
						print("caught")
						GlobalSignals.emit_signal("playerCaught")
				else:
					print("not catchable :<")
