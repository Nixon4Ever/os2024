extends CharacterBody2D

var health = 100

signal health_depleted

func _physics_process(delta):
	var direction = Input.get_vector("MoveLeft","MoveRight" ,"MoveUp" ,"MoveDown")
	velocity = direction * 400
	move_and_slide()

	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		if health:
			health_depleted.emit()


