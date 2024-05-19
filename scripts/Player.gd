extends CharacterBody2D

var health := 100.0
var direction := 0.0
var speed := 0.0

var ang_accel :=.008
var turn_max :=.025
var accel := 600.0
var speed_max := 500.0
var speed_reverse_max := 200.0

var experience = 0
var experience_level = 1
var collected_experience = 0

@onready var expbar = get_node("%ExperienceBar")
@onready var lbllevel = get_node("%Level")


func _ready():
	set_expbar(experience, calculate_experiencecap())

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
	elif speed < -speed_reverse_max:
		speed = -speed_reverse_max
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

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experience(gem_exp)
		
func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required:
		collected_experience -= exp_required-experience
		experience_level += 1
		experience = 0 
		exp_required = calculate_experiencecap()
		calculate_experience(0)
	else:
		experience += collected_experience
		collected_experience = 0
	
	set_expbar(experience,exp_required)

func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level * 5
	elif experience_level < 40:
		exp_cap = 95 * (experience_level-19)*8
	else:
		exp_cap = 255 + (experience_level-39)*12
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	expbar.value = set_value
	expbar.max_value = set_max_value

