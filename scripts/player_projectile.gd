extends Area2D

@onready var icon_obj := $Sprite2D
var damage:=0
var velocity:=Vector2(0,0)
var pierce:= 0
var life:=0.0
var ang_vel:=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_body_entered(body):
	if body.has_method("take_damage"):
		pierce-=1
		if pierce == 0:
			queue_free()
		body.take_damage(44)
func setIcon(icon):
	icon_obj.texture=icon
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=velocity*delta
	rotation+=ang_vel*delta
	life+=delta
	
	if life>10:
		queue_free()
