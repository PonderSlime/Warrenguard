extends Node

var player_health : int
var start_health : int = 3
var carrots : int = 0
var prev_carrots : int = 0
var current_scene = null
var did_just_doorway : bool = false
var door_pos : Vector2
var cellPosition : Vector2

var current_power_up : int = 0
var prev_power_up : int = 0
var player_default_movement_speed : float = 120
var player_current_movement_speed : float = 0


func _ready():
	player_health = start_health
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func _process(delta):
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Now, we can call our save function on each node.
		pass
	save()
	save_game()
	if carrots < 0:
		carrots = 0
		GlobalVariableLoader.prev_carrots = GlobalVariableLoader.carrots
	if current_power_up == 1:
		player_current_movement_speed = player_default_movement_speed + 100
		await get_tree().create_timer(0.001).timeout
		prev_power_up = current_power_up
		await get_tree().create_timer(5.0).timeout
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

func save():
	var save_dict = {
		
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"player_health" : player_health,
		"carrots" : carrots,
		"current_scene" : current_scene,
	}
	return save_dict
	
# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(json_string)
