extends Node2D

@onready var tile_map = $TileMap


static func string_to_vector2(string := "") -> Vector2:
	if string:
		var new_string: String = string
		new_string = new_string.erase(0, 1)
		new_string = new_string.erase(new_string.length() - 1, 1)
		var array: Array = new_string.split(", ")

		return Vector2(int(array[0]), int(array[1]))

	return Vector2.ZERO
	
func _ready():
	var saveFile = FileAccess.open("user://warren.save", FileAccess.READ)
	if(FileAccess.get_open_error() != OK):
		return false
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

		# Firstly, we need to create the object and add it to the tree and set its position.
		var layer = node_data["layer"]
		var pos = string_to_vector2(node_data["pos"])
		var coords = string_to_vector2(node_data["coords"])
		var source = node_data["source"]
		var altTile = node_data["alt_tile"]
		tile_map.set_cell(layer, pos, source, coords, altTile)
func save_game():
	var saveFile = FileAccess.open("user://warren.save", FileAccess.WRITE)
	if(FileAccess.get_open_error() != OK):
		return false
	for layer in tile_map.get_layers_count():
		for y in tile_map.get_used_rect().size.y:
			for x in tile_map.get_used_rect().size.x:
				var pos : Vector2i = Vector2i(x, y)
				var coords : Vector2i = tile_map.get_cell_atlas_coords(layer, pos)
				var source : int = tile_map.get_cell_source_id(layer, pos)
				var altTile : int = tile_map.get_cell_alternative_tile(layer, pos)
				var save_dict = {"layer" : layer, "pos" : pos, "coords": coords, "source": source, "alt_tile": altTile }
				
				var json_string = JSON.stringify(save_dict)
				saveFile.store_line(json_string)
