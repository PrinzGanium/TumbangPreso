extends Node3D

@onready var barrel = $RayCast3D

var proj = load("res://MenuNavigation/Games/TumbangPreso/Thrower/tsinelas_projectile.tscn")
var instance



func throw():
	instance = proj.instantiate()
	instance.position = global_position
	instance.transform.basis = barrel.global_transform.basis
	instance.throw_dir = (barrel.global_basis * barrel.target_position).normalized()
	get_tree().root.add_child(instance)

func _process(delta: float) -> void:
	#print($RayCast3D.global_rotation)
	pass
