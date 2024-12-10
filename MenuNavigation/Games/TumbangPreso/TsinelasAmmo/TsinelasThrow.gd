extends Node3D

@onready var barrel = $RayCast3D

var proj = load("res://MenuNavigation/Games/TumbangPreso/TsinelasAmmo/tsinelas_projectile.tscn")
var instance

func throw(strength):
	instance = proj.instantiate()
	instance.throw_strength *= strength
	instance.position = global_position
	instance.transform.basis = barrel.global_transform.basis
	instance.throw_dir = (barrel.global_basis * barrel.target_position).normalized()
	get_tree().root.add_child(instance)

func _process(delta: float) -> void:
	
	pass
