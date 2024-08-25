extends Node2D

@onready var camera = $PhantomCamera2D
@export var player : CharacterBody2D
var TimeStart : int = 100
var TimeInSeconds : int = TimeStart
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariableLoader.unlockCamera == true:
		camera.follow_mode = 0
		if TimeInSeconds > 0:
			TimeInSeconds -= delta
			camera.zoom += Vector2(0.005,0.005)
	elif GlobalVariableLoader.unlockCamera == false:
		camera.follow_mode = 5
		camera.zoom = Vector2(2,2)
		TimeInSeconds = TimeStart
