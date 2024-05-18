extends CharacterBody2D

var movement_speed = 200
var health = 10
var experience = 1

@onready var player = $"../Player"
@onready var loot_base = get_tree().get_first_node_in_group("loot")


var exp_gem = load("res://scenes/experince_orb.tscn")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()

func take_damage_cannon():
	const DAMAGE = 4
	health -= DAMAGE
	
	if health <= 0:
		death()

func death():
	var exp_gem = load("res://scenes/experince_orb.tscn")
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.add_child(new_gem)
	queue_free()
	

