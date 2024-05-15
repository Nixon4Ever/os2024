extends CharacterBody2D

var health := 100.0
var direction := 0.0
var speed := 0.0

var ang_accel :=.008
var turn_max :=.05
var accel := 500.0
var speed_max := 200.0

var experience = 0
var experience_level = 1
var collected_experience = 0

signal health_depleted

func _physics_process(delta):
	#SPEED INPUT
	if Input.is_action_pressed("MoveUp"):
		speed += accel*delta
	elif Input.is_action_pressed("MoveDown"):
		speed -= accel*delta
	elif speed < 0:
		speed += accel*delta
		if speed >0:
			speed = 0
	elif speed > 0:
		speed -= accel*delta
		if speed < 0:
			speed = 0
	#SPEED CLAMP
	if speed > speed_max:
		speed = speed_max
	elif speed < -speed_max:
		speed = -speed_max
	var dir_input := 0.0
	if Input.is_action_pressed("MoveLeft"):
		dir_input = -1
	if Input.is_action_pressed("MoveRight"):
		dir_input += 1
	
	direction +=clampf(speed*dir_input*delta*ang_accel,-turn_max,turn_max)
	
	velocity = Vector2.from_angle(direction)*speed
	move_and_slide()
	if velocity.length() != 0:
		if speed >0:
			%Raft.rotation = velocity.angle() - (PI/2)
		else:
			%Raft.rotation = velocity.angle() + (PI/2)

	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()


