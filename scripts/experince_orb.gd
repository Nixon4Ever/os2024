extends Area2D

@export var experience = 1

var spr_cheeseburger = preload("res://textures/xp items/cheeeseburger.png")
var spr_steak = preload("res://textures/xp items/steak.png")
#var spr_enchiladas = preload()

var target = null
var speed = -2

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	if experience < 5:
		return
	elif experience <25:
		sprite.texture = spr_steak
	#else:
		#sprite.texture = spr_enchiladas

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 10 * delta
		

func collect():
	#sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return experience
	
func _on_snd_collected_finished():
	queue_free()
