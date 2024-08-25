extends StaticBody2D
@onready var audio = $AudioStreamPlayer2D
@onready var state_machine = $AnimationTree.get("parameters/playback")
var degree : int
# Called when the node enters the scene tree for the first time.
func _ready():
	degree = round_to_dec(rotation_degrees, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _process(delta):
	pass
	
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		state_machine.travel("boing")
		audio.stop()
		audio.play()
		if degree == 0:
			body.fungi_up()
		elif degree == 45 or degree == -315:
			body.fungi_up_right()
		elif degree == 90 or degree == -270:
			body.fungi_right()
		elif degree == 135 or degree == -225:
			body.fungi_down_right()
		elif degree == 180 or degree == -180:
			body.fungi_down()
		elif degree == 225 or degree == -135:
			body.fungi_down_left()
		elif degree == 270 or degree == -90:
			body.fungi_left()
		elif degree == 315 or degree == -45:
			body.fungi_up_left()
