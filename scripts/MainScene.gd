extends Node

var gameScene = preload("res://scenes/Main2D.tscn")
@onready var menu = $MainMenu
@onready var timer = $CanvasLayer/Timer
var gameObj = null

var in_game := false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func end_game():
	if in_game:
		in_game=false
		menu.visible=true
		timer.visible = false
		gameObj.queue_free()

func _on_play_button_button_down():
	if !in_game:
		in_game=true
		menu.visible=false
		timer.visible = true
		gameObj = gameScene.instantiate()
		add_child(gameObj)


func _on_quit_button_button_down():
	get_tree().quit()
