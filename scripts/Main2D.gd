extends Node2D



func spawn_enemy():
	var new_enemy = preload("res://scenes/BasicSerpent.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	add_child(new_enemy)
	

func spawn_boss():
	var new_boss = preload("res://scenes/FatAngler.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_boss.global_position = %PathFollow2D.global_position
	add_child(new_boss)


func _on_timer_timeout():
	spawn_enemy()


func _on_timer_spawn_boss():
	spawn_boss()
	
	

func _on_player_health_depleted():
	$GameOver.visible = true
	get_tree().paused = true
