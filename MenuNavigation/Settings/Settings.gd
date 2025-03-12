extends Node

enum modes {COMP, MOBILE}
var mode = modes.COMP

func setmode(newmode):
	mode = newmode
