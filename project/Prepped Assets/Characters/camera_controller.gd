extends Node2D

@onready var camera = $PhantomCamera2D
@export var PlayerRoot : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(camera.follow_mode)


func _on_player_death():
	camera.follow_mode = 0
	camera.zoom += Vector2(0.005,0.005)
