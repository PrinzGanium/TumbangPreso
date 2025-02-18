extends Node

signal guardCommand(command)
signal mapReady
signal playerAware(command)
signal playerCaught
signal canHit

func ignore() -> void:
	guardCommand.emit()
	mapReady.emit()
	playerAware.emit()
	playerCaught.emit()
	canHit.emit()
