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
var time_total:= 0.0

@onready var expbar = get_node("%ExperienceBar")
@onready var lbllevel = get_node("%Level")
@onready var levelPanel = get_node("%LevelUp")
@onready var itemOptions = preload("res://scenes/item_option.tscn")
@onready var upgradeOptions = get_node("%UpgradeOptions")

var playerProjScene = preload("res://scenes/player_projectile.tscn")
@onready var projectilesObj = get_tree().root.get_child(0).get_node("Main2D/Projectiles")
@onready var weaponsObj = get_tree().root.get_child(0).get_node("Main2D/Player/gui/Control/WeaponsContainer")

func _ready():
	set_expbar(experience, calculate_experiencecap())

signal health_depleted

func _physics_process(delta):
	time_total+=delta
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
	for n in range(0,weaponsObj.weapons.size()):
		var weaponName = weaponsObj.weapons[n]
		var weaponLvl = weaponsObj.weapons_lvl[n]
		var fireRate = weaponsObj.weaponDict[weaponName]["upgrades"][0]["fire_rate"]
		if fmod(time_total,fireRate)<fireRate and fmod(time_total,fireRate)+delta>fireRate:
			if weaponName == "Axe":
				var proj = playerProjScene.instantiate()
				proj.position=position
				proj.velocity = Vector2.from_angle(randf()*PI*2)*1000
				proj.ang_vel = 10
				proj.pierce=2
				projectilesObj.add_child(proj)
				proj.setIcon(weaponsObj.IconDict["Axe"])

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
		level_up()
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

func level_up():
	lbllevel.text = str("Level:", experience_level)
	var tween = levelPanel.create_tween()
	tween.tween_property(levelPanel, "position", Vector2(376,74),0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelPanel.visible = true
	var options = 0
	var optionsmax = 3
	while options < optionsmax:
		var option_choice = itemOptions.instantiate()
		upgradeOptions.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	levelPanel.visible = false
	levelPanel.position = Vector2 (1200,107.5)
	get_tree().paused = false
	calculate_experience(0)
