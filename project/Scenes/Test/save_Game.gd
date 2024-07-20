extends Node2D

@onready var tile_map = $TileMap
# Called when the node enters the scene tree for the first time.

func _ready():
	print("ready!")
	var saveFile = FileAccess.open("user://savegame.save", FileAccess.READ)
	#print(saveFile)
	#if(FileAccess.get_open_error() != OK):
		#return false
	#var jsonData = saveFile.get_as_text()
	#var json_conv = JSON.new()
	#json_conv.parse(jsonData)
	#var loadedData = json_conv.get_data()
	##loadedData should be dictionary in same format as when you saved it
	##so you should be able to restore tiles in tilemap like
	#for layer in tile_map.get_layers_count():
		## not cooordinates here, you got to call .pos
		#for y in tile_map.get_used_rect().size.y:
			#for x in tile_map.get_used_rect().size.x:
					## each layer is defined by touple with {}:	myTileMapData.data[layer].append( {"pos": pos, "coords": coords, "source": source, "alt_tile": altTile } )
					## need an interator to count layers to count the touples
					## or each touple has a lyaer # stored in it
				#print(loadedData.data[layer][y*100 + x].pos)
				#var coords = Vector2i(str_to_var(loadedData.data[layer][y*100 + x].pos))
				#tile_map.set_cell(layer, coords, loadedData.data[layer][y*100 + x].source, loadedData.data[layer][y*100 + x].coords, loadedData.data[layer][y*100 + x].alt_tile)
					##
					###saveFile.store_string(JSON.stringify(myTileMapData))
					##var pos : Vector2i = Vector2i(x, y)
					##var coords : Vector2i = tile_map.get_cell_atlas_coords(layer, pos)
					##var source : int = tile_map.get_cell_source_id(layer, pos)
					##var altTile : int = tile_map.get_cell_alternative_tile(layer, pos)
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
		#var new_object = load(node_data["filename"]).instantiate()
		#var pos = load(node_data["pos"]).instantiate()
		var pos = Vector2(str_to_var(node_data["pos"]))
		var coords = Vector2(str_to_var(node_data["coords"]))
		var source = int(str_to_var(node_data["source"]))
		var altTile = int(str_to_var(node_data["altTile"]))
		tile_map.set_cell(0, pos, coords, source, altTile)
		
		#get_node(node_data["parent"]).add_child(new_object)
		#new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		#for i in node_data.keys():
			#if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				#continue
			#new_object.set(i, node_data[i])
func load_game():
	#print("loading")
	#var saveFile = FileAccess.open("user://savefile.save", FileAccess.READ)
	#if(FileAccess.get_open_error() != OK):
		#return false
	#var jsonData = saveFile.get_as_text()
	#var json_conv = JSON.new()
	#json_conv.parse(jsonData)
	#var loadedData = json_conv.get_data()
	##loadedData should be dictionary in same format as when you saved it
	##so you should be able to restore tiles in tilemap like
	#for y in 100:
		#for x in 100:
			#for layer in loadedData.data.size():
				#tile_map.set_pattern(layer, loadedData.data[layer][y*100 + x].pos, loadedData.data[layer][y*100 + x].source, loadedData.data[layer][y*100 + x].coords, loadedData.data[layer][y*100 + x].alt_tile)
	pass
func save_game():
	#var savegame := SaveGame.new()
	#savegame.game_version = ProjectSettings.get_setting("application/config/version")
			#
	#for c in tile_map.get_children():
		#savegame.tile_map.push_back(c.save())
#
	##var path = "res://Levels/Level_" + String(GlobalVariableLoader.activeLevelNo) + ".res"
	##var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	#var err = ResourceSaver.save(savegame, "user://savegame.save")
	#if err != 0:
		#print("error saving game in Level Editor, code: ", err)
	#Dictionary with tilemap data to save, you can save it as json or something
	#print(tile_map.size)
	print(tile_map.get_used_rect().size.x)
	#var myTileMapData : Dictionary = { "data": [] }
	var saveFile = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if(FileAccess.get_open_error() != OK):
		return false
	for layer in tile_map.get_layers_count():
		for y in tile_map.get_used_rect().size.y:
			for x in tile_map.get_used_rect().size.x:
				#if(myTileMapData.data.size() <= layer):
					#myTileMapData.data.append( [] )
				var pos : Vector2i = Vector2i(x, y)
				var coords : Vector2i = tile_map.get_cell_atlas_coords(layer, pos)
				var source : int = tile_map.get_cell_source_id(layer, pos)
				var altTile : int = tile_map.get_cell_alternative_tile(layer, pos)
				var save_dict = {"pos": pos, "coords": coords, "source": source, "alt_tile": altTile }
				
				var json_string = JSON.stringify(save_dict)
				saveFile.store_line(json_string)
	#Now you can save myTileMapData
	
	
	print("saved")

	#saveFile.store_string(JSON.stringify(myTileMapData))
