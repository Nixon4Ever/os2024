extends Area2D

var damage = 4
var has_cannon:=false
const BALL = preload("res://scenes/cannonball.tscn")


@onready var weaponsObj = get_tree().root.get_child(0).get_node("Main2D/Player/gui/Control/WeaponsContainer")

func set_firerate(new_rate):
	$Timer.wait_time=new_rate

func _physics_process(delta):
	for n in range(0,weaponsObj.weapons.size()):
		var weaponName = weaponsObj.weapons[n]
		if weaponName == "Cannon":
			has_cannon=true
			var enemies_in_range = get_overlapping_bodies()
			if enemies_in_range.size() > 0:
				var target_enemy = enemies_in_range.front()
				look_at(target_enemy.global_position)

func shoot():
	if has_cannon:
		var new_ball = BALL.instantiate()
		new_ball.damage = damage
		new_ball.global_position = %"shooting point".global_position
		new_ball.global_rotation = %"shooting point".global_rotation
		%"shooting point".add_child(new_ball)

func _on_timer_timeout():
	shoot()
