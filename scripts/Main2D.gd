extends Node2D

var time = 0.0
var basic_enemy = preload("res://scenes/BasicSerpent.tscn")
var red_serpent = preload("res://scenes/red_serpent.tscn")

func _process(delta):
	time += delta
	if time + delta > 120.0 and time <= 120:
		spawn_boss()

func spawn_enemy():
	var enemy
	%PathFollow2D.progress_ratio = randf()
	if time < 60:
		enemy = basic_enemy.instantiate()
	else:
		enemy = red_serpent.instantiate()
	enemy.global_position = %PathFollow2D.global_position
	enemy.health = 5 + int(time/5)
	enemy.damage = 5 + int(time/5)
	add_child(enemy)

func spawn_boss():
	var new_boss = preload("res://scenes/FatAngler.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_boss.global_position = %PathFollow2D.global_position
	add_child(new_boss)

func _on_timer_timeout():
	spawn_enemy()

func _on_player_health_depleted():
	$GameOver.visible = true
	get_tree().paused = true

