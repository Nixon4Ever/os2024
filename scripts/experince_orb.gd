extends Area2D

@export var experience = 1

var spr_cheeseburger = preload()
var spr_ = preload()
var spr_ = preload()

var target = null
var speed = 0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	if experience < 5:
		return
	elif experience <25:
		sprite.texture = spr_
	else:
		sprite.texture = spr_

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta
		

func collect():
	queue_free()
