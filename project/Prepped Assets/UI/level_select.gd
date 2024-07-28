extends Node2D
func load_game():
	pass
func save_game():
	pass
@export var scene_type : int = 2
@export var scene_1 = "res://Scenes/Test/test_scene_1.tscn"
@export var scene_2 = "res://Scenes/Test/test_lava_scene_1.tscn"
@export var scene_3 = "res://Scenes/Test/test_scene_3.tscn"
@onready var _anim_player = $SceneTransition/AnimationPlayer
func _ready():
	GlobalVariableLoader.active_level = scene_type
	
func _process(delta):
	if !$TileMap/Sprite2D/AudioStreamPlayer2D.is_playing():
		$TileMap/Sprite2D/AudioStreamPlayer2D.play()


func _on_level_1_start_pressed():
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.01).timeout
	_anim_player.play("dissolve")
	await get_tree().create_timer(0.8333).timeout
	GlobalVariableLoader.goto_scene(scene_1)


func _on_level_2_start_pressed():	
	if GlobalVariableLoader.progress_level >= 1:
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.01).timeout
		_anim_player.play("dissolve")
		await get_tree().create_timer(0.8333).timeout
		GlobalVariableLoader.goto_scene(scene_2)



func _on_level_3_start_pressed():
	if GlobalVariableLoader.progress_level >= 2:
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.01).timeout
		_anim_player.play("dissolve")
		await get_tree().create_timer(0.8333).timeout
		GlobalVariableLoader.goto_scene(scene_3)
