extends CharacterBody2D

var movement_speed = 500
var health = 200
var experience = 30
var damage = 10


@onready var player = $"../Player"
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var ap = $AnimationPlayer

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()
	

func take_damage(damage):
	health -= damage
	
	if health <= 0:
		death()

func death():
	print("DEATH")
	ap.play("Fat_angler_death")

	

func _on_animation_player_animation_finished(Fat_angler_death):
	var exp_gem = load("res://scenes/experince_orb.tscn")
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child",new_gem)
	queue_free()
