extends Area2D

@export var switch_to_scene : String = "res://Prepped Assets/Environment/next_level.tscn"
@export var is_internal : bool = true
@export var active_level : int = 0
@export var _anim_player : AnimationPlayer
@export var is_level_end : bool = false
@onready var parent = get_tree().get_nodes_in_group("parent")[0]
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariableLoader.door_pos = global_position

func _on_area_2d_body_entered(body):
	if body.name == "Player" or body.name == "PlayerRPG" or body.name == "PlayerRPGDigger":
		if is_internal:
			GlobalVariableLoader.active_level = 0
		elif !is_internal:
			GlobalVariableLoader.progress_level += 1
			GlobalVariableLoader.active_level = active_level
		_anim_player.play("dissolve")
		GlobalVariableLoader.stored_carrots += GlobalVariableLoader.carrots
		GlobalVariableLoader.carrots = 0
		parent.save_game()
		await get_tree().create_timer(0.8333).timeout
		GlobalVariableLoader.goto_scene(switch_to_scene)
		GlobalVariableLoader.door_pos = Vector2.ZERO
		GlobalVariableLoader.switch_scene = true
		if is_level_end == false:
			GlobalVariableLoader.did_just_doorway = true
		#_anim_player.play_backwards("dissolve")
