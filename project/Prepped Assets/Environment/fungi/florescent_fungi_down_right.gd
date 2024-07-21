extends StaticBody2D
@onready var audio = $AudioStreamPlayer2D
@onready var state_machine = $AnimationTree.get("parameters/playback")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _physics_process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		state_machine.travel("boing")
		body.fungi_down_right()
		audio.stop()
		audio.play()
