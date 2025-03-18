extends Control

@onready var bub = $TextBubble
#@onready var talks = load("res://MenuNavigation/Games/TumbangPreso/GeneralUI/UIBase/ui.tscn::AtlasTexture_icnc4")

var ShoutAtlas = {
	"ThrowerHit": Rect2(13.0, 0.0, 401.0, 353.0),
	"ThrowerAmmo": Rect2(13.0, 366.0, 401.0, 353.0),
	"ThrowerWarn": Rect2(0.0, 821.0, 401.0, 353.0),
	"TayaHit": Rect2(513.0, 0.0, 401.0, 353.0),
	"TayaWarn": Rect2(514.0, 366.0, 401.0, 353.0),
	"TayaAmmo": Rect2(513.0, 795.0, 401.0, 353.0)
}

func _ready() -> void:
	pass

func shout(ver : String, n : int) -> void:
	if ver == "Tapon":
		match n:
			0: bub.texture.region = ShoutAtlas["ThrowerHit"]
			1: bub.texture.region = ShoutAtlas["ThrowerAmmo"]
			2: bub.texture.region = ShoutAtlas["ThrowerWarn"]
	if ver == "Taya":
		match n:
			0: bub.texture.region = ShoutAtlas["TayaHit"]
			1: bub.texture.region = ShoutAtlas["TayaWarn"]
			2: bub.texture.region = ShoutAtlas["TayaAmmo"]
	$AnimationPlayer.play("Appear+Fade")
