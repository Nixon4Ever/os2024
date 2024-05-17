extends Area2D


func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		
func shoot():
	const BALL = preload("res://scenes/cannonball.tscn")
	var new_ball = BALL.instantiate()
	new_ball.global_position = %"shooting point".global_position
	new_ball.global_rotation = %"shooting point".global_rotation
	%"shooting point".add_child(new_ball)

func _on_timer_timeout():
	shoot()
