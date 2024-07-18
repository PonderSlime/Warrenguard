extends Area2D

@export var switch_to_scene : String = "res://Scenes/Test/test_warren_1.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	#GlobalVariableLoader.door_pos = global_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariableLoader.door_pos = global_position
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player" or body.name == "PlayerRPG":
		GlobalVariableLoader.goto_scene(switch_to_scene)
		GlobalVariableLoader.did_just_doorway = true
