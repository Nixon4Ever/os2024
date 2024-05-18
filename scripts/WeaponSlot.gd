extends Control
@onready var tex = $Texture
@onready var level = $Level

func changeWep(newTex,newLevel):
	tex.texture = newTex
	if newLevel == 0:
		level.text = ""
	else:
		level.text = str(newLevel)
