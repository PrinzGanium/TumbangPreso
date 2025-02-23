extends RigidBody3D

var throw_dir : Vector3 = Vector3.FORWARD
var throw_strength = 8000
var grace = false

var pickup  : Resource = load("res://MenuNavigation/Games/TumbangPreso/TsinelasAmmo/tsinelas_pickup.tscn")
var instance

var despawnflag = false
func _ready() -> void:
	apply_central_force(throw_dir * throw_strength)
	apply_torque((Vector3.MODEL_LEFT).normalized()*throw_strength/50)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if linear_velocity.length() <= 0.2 and grace and not despawnflag:
		despawn()
	pass


func _on_grace_period_timeout() -> void:
	grace = true
	pass # Replace with function body.


func _on_timeout_timeout() -> void:
	#despawn()
	pass # Replace with function body.

func despawn():
	despawnflag = true
	instance = pickup.instantiate()
	instance.position = global_position
	instance.transform.basis = transform.basis
	get_parent().add_child(instance)
	global_position = Vector3.DOWN * 1000
	
	call_deferred("queue_free")
	pass
