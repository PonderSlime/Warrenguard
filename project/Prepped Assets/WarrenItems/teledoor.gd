extends Node2D

@export var switch_to_scene : String = "res://Scenes/Test/test_warren_1.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player" or body.name == "PlayerRPG":
		GlobalVariableLoader.goto_scene(switch_to_scene)
