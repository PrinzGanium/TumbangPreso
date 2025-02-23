extends Node

signal ammochange
@export var ammo = 3:
	set(val):
		ammo = val
		ammochange.emit()
	get:
		return ammo
@onready var ammotext = $"../Head/Camera3D/Thrower/HUD/TsinelasLabel"

@export var canTag = false
@onready var tagLabel = $"../Head/Camera3D/Thrower/HUD/WarningLabel"

func _process(_delta: float) -> void:
	ammotext.text = "Tsinelas:" + str(ammo)

func tag():
	tagLabel.text = "Maari kang hulihin!!!"

func untag():
	tagLabel.text = "Di ka mahuhuli dito!"
