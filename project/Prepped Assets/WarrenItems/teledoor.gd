extends Area2D

@export var switch_to_scene : String = "res://Scenes/Test/test_warren_1.tscn"
@export var _anim_player : AnimationPlayer
@onready var parent = get_tree().get_nodes_in_group("parent")[0]
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariableLoader.door_pos = global_position

func _on_area_2d_body_entered(body):
	if body.name == "Player" or body.name == "PlayerRPG":
		_anim_player.play("dissolve")
		GlobalVariableLoader.stored_carrots += GlobalVariableLoader.carrots
		GlobalVariableLoader.carrots = 0
		parent.save_game()
		await get_tree().create_timer(0.8333).timeout
		GlobalVariableLoader.goto_scene(switch_to_scene)
		GlobalVariableLoader.door_pos = Vector2.ZERO
		GlobalVariableLoader.switch_scene = true
		GlobalVariableLoader.did_just_doorway = true
		#_anim_player.play_backwards("dissolve")
