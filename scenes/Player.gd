extends CharacterBody2D


func _physics_process(delta):
	var direction = Input.get_vector("MoveLeft", "MoveDown", "MoveRight","MoveUp")
	velocity = direction * 400
