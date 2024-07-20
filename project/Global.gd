extends Node

var player_health : int
var start_health : int = 3
var carrots : int = 0
var prev_carrots : int = 0
var current_scene = null
var did_just_doorway : bool = false
var door_pos : Vector2
var cellPosition : Vector2

var activeLevelNo : String

var current_power_up : int = 0
var prev_power_up : int = 0
var player_default_movement_speed : float = 120
var player_current_movement_speed : float = 0

func _ready():
	player_health = start_health
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func _process(delta):
	if carrots < 0:
		carrots = 0
		GlobalVariableLoader.prev_carrots = GlobalVariableLoader.carrots
	if current_power_up == 1:
		player_current_movement_speed = player_default_movement_speed + 100
		await get_tree().create_timer(0.001).timeout
		prev_power_up = current_power_up
		await get_tree().create_timer(15.0).timeout
		current_power_up = 0
		await get_tree().create_timer(0.001).timeout
		prev_power_up = 0
	elif current_power_up == 0: 
		player_current_movement_speed = player_default_movement_speed
func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)	

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
