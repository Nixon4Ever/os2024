extends Sprite2D
var Velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	Velocity = Vector2(0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		position -= Vector2(.3,0)
	pass
