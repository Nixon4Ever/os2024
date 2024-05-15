extends Panel
var time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	$TimerText.text=str(floor(time/60))+":"+("0" if int(time)%60<10 else "")+str(int(time)%60)
