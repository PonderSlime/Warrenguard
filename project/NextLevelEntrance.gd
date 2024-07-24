extends Area2D

@onready var level_1 = "res://Scenes/Test/test_scene_1.tscn"
@onready var level_2 = "res://Scenes/Test/test_lava_scene_1.tscn"
@export var _anim_player : AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariableLoader.progress_level >= 3:
		GlobalVariableLoader.progress_level = 2
func _on_body_entered(body):
	if body.name == "Player":
		GlobalVariableLoader.progress_level += 1
		_anim_player.play("dissolve")
		await get_tree().create_timer(0.8333).timeout
		if GlobalVariableLoader.progress_level == 1:
			await get_tree().create_timer(0.8333).timeout
			GlobalVariableLoader.goto_scene(level_1)
			GlobalVariableLoader.switch_scene = true
		elif GlobalVariableLoader.progress_level == 2:
			GlobalVariableLoader.goto_scene(level_2)
			GlobalVariableLoader.switch_scene = true
				
