extends Node

signal guardCommand(command)
signal mapReady
signal playerAware(command)
signal playerCaught
signal canHit

signal ThrowerInArea
signal ThrowerOutArea
signal canTake
signal canReturn
signal canDown

var passScore = 0
var timeleft = 0
var passtime = false

func ignore() -> void:
	guardCommand.emit()
	mapReady.emit()
	playerAware.emit()
	playerCaught.emit()
	canHit.emit()
	ThrowerOutArea.emit()
	ThrowerInArea.emit()
	canDown.emit()
	canTake.emit()
	canReturn.emit()
