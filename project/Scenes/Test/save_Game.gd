extends Node2D

@onready var tile_map = $TileMap
# Called when the node enters the scene tree for the first time.

func _ready():
	print("ready!")
	var saveFile = FileAccess.open("user://savegame.save", FileAccess.READ)
	print(saveFile)
	if(FileAccess.get_open_error() != OK):
		return false
	var jsonData = saveFile.get_as_text()
	var json_conv = JSON.new()
	json_conv.parse(jsonData)
	var loadedData = json_conv.get_data()
	#loadedData should be dictionary in same format as when you saved it
	#so you should be able to restore tiles in tilemap like
	#for y in loadedData.data.size():
		#for x in loadedData.data.size():
			#for layer in loadedData.data.size():
				#tile_map.set_cell(layer, loadedData.data[layer][y*100 + x].pos, loadedData.data[layer][y*100 + x].source, loadedData.data[layer][y*100 + x].coords, loadedData.data[layer][y*100 + x].alt_tile)

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
	var myTileMapData : Dictionary = { "data": [] }

	for y in 100:
		for x in 100:
			for layer in tile_map.get_layers_count():
				if(myTileMapData.data.size() <= layer):
					myTileMapData.data.append( [] )
				var pos : Vector2i = Vector2i(x, y)
				var coords : Vector2i = tile_map.get_cell_atlas_coords(layer, pos)
				var source : int = tile_map.get_cell_source_id(layer, pos)
				var altTile : int = tile_map.get_cell_alternative_tile(layer, pos)
				myTileMapData.data[layer].append( { "pos": pos, "coords": coords, "source": source, "alt_tile": altTile } )

	#Now you can save myTileMapData
	var saveFile = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if(FileAccess.get_open_error() != OK):
		return false
	print("saved")

	saveFile.store_string(JSON.stringify(myTileMapData))
