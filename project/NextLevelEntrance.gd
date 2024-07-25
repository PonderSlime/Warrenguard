extends Area2D

@onready var level_1 = "res://Scenes/Test/test_scene_1.tscn"
@onready var level_2 = "res://Scenes/Test/test_lava_scene_1.tscn"
@export var level_count : int = 2
@export var _anim_player : AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariableLoader.progress_level > level_count - 1:
		GlobalVariableLoader.progress_level = 1
func _on_body_entered(body):
	if body.name == "Player":
		_anim_player.play("dissolve")
		await get_tree().create_timer(0.8333).timeout
		if GlobalVariableLoader.progress_level == 0:
			await get_tree().create_timer(0.8333).timeout
			GlobalVariableLoader.goto_scene(level_1)
			GlobalVariableLoader.switch_scene = true
			GlobalVariableLoader.active_level = 2
		elif GlobalVariableLoader.progress_level == 1:
			GlobalVariableLoader.goto_scene(level_2)
			GlobalVariableLoader.switch_scene = true
			GlobalVariableLoader.active_level = 3
				
