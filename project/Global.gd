extends Node

var stored_carrots : int = 0
var progress_level : int = 0

var player_health : int
var start_health : int = 3
var carrots : int = 0
var prev_carrots : int = 0
var current_scene = null
var did_just_doorway : bool = false
var switch_scene : bool = false
var door_pos : Vector2
var cellPosition : Vector2
var activeLevelNo : String
var reset_player_loc : bool = false
var current_power_up : int = 0
var prev_power_up : int = 0
var player_default_movement_speed : float = 120
var player_current_movement_speed : float = 0
var unlockCamera : bool = false
var player_pos : Vector2
var active_level : int = 0
var is_frozen : bool = false
var player_tile_pos : Vector2

var build_item : int = 0
func _ready():
	player_health = start_health
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	var saveFile = FileAccess.open("user://game_stats.save", FileAccess.READ)
	if(FileAccess.get_open_error() != OK):
		return false
	else:
		while saveFile.get_position() < saveFile.get_length():
			var json_string = saveFile.get_line()

			# Creates the helper class to interact with JSON
			var json = JSON.new()

			# Check if there is any error while parsing the JSON string, skip in case of failure
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
				continue

			# Get the data from the JSON object
			var node_data = json.get_data()
			
			# Firstly, we need to create the object and add it to the tree and set its position
			stored_carrots = node_data["cached_carrots"]
			var health = node_data["health"]
			progress_level = node_data["prog_level"]
func _process(delta):
	save_game()
	if carrots < 0:
		carrots = 0
		prev_carrots = carrots
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
	
func save_game():
	var saveStats = FileAccess.open("user://game_stats.save", FileAccess.WRITE)
	if(FileAccess.get_open_error() != OK):
		return false
	var current_cached_carrot_count : int = stored_carrots
	var current_health : int = player_health
	var prog_level : int = progress_level
	var save_dict = {"cached_carrots" : current_cached_carrot_count, "health" : current_health, "prog_level" : prog_level}
	
	var json_string = JSON.stringify(save_dict)
	saveStats.store_line(json_string)
