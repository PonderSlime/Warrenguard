extends Area2D

@export var switch_to_scene : String = "res://Scenes/Test/test_warren_1.tscn"
@export var _anim_player : AnimationPlayer
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariableLoader.door_pos = global_position

func _on_area_2d_body_entered(body):
	if body.name == "Player" or body.name == "PlayerRPG":
		_anim_player.play("dissolve")
		await get_tree().create_timer(0.8333).timeout
		GlobalVariableLoader.goto_scene(switch_to_scene)
		GlobalVariableLoader.door_pos = Vector2.ZERO
		GlobalVariableLoader.did_just_doorway = true
		_anim_player.play_backwards("dissolve")
