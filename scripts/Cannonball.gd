extends Area2D

var distance_travelled = 0

const SPEED = 1000
const RANGE = 1200

func _physics_process(delta):
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	distance_travelled += SPEED * delta
	if distance_travelled > RANGE:
		queue_free()
	

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage_cannon"):
		body.take_damage_cannon()
