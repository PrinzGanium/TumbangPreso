extends RayCast3D

signal playerCaught


@export var auto = false
@onready var stats = $"../../../PlayerStats"
@onready var prompt = $Prompt
@onready var base = $"../../.."

var holdCan = false
@onready var canModel = $"../Can"
func ignore():
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
					holdCan = true
					base.Capture = false
					
					canModel.show()
					GlobalSignals.canTake.emit()
			
			if collider.is_in_group("playarea"):
				var s = collider.interact(self)
				if s:
					holdCan = false
					base.Capture = true
					canModel.hide()
					GlobalSignals.canReturn.emit()
			
			if collider.is_in_group("tapon"):
				var s = collider.interact(self)
				if s:
					print("caught")
					GlobalSignals.emit_signal("playerCaught")


func _on_action_button_pressed() -> void:
	pass # Replace with function body.
