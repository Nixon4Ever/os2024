extends Area2D

@export var experience = 1

var spr_coin = preload("res://textures/xp items/coin.png")


var target = null
var speed = -2

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var ap = %AnimationPlayer
@onready var sound = $snd_collected


func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 10 * delta
		
		animation()

func animation():
	ap.play("Coin")

func collect():
	sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return experience
	
func _on_snd_collected_finished():
	queue_free()
