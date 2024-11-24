extends Node

@export var ammo = 3
@onready var ammotext = $"../Head/Camera3D/Thrower/HUD/TsinelasLabel"

@export var canTag = false
@onready var tagLabel = $"../Head/Camera3D/Thrower/HUD/WarningLabel"

func _process(_delta: float) -> void:
	ammotext.text = "Tsinelas:" + str(ammo)


func tag():
	canTag = true
	tagLabel.text = "Maari kang hulihin!!!"

func untag():
	canTag = false
	tagLabel.text = "Di ka mahuhuli dito!"
