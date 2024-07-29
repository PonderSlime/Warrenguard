extends TileMap
var damaged_tiles = {}
var tile_positioni
func _ready():
	pass

func _process(delta):
	for tile_position in damaged_tiles:
		var tile = damaged_tiles[tile_position]
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var cells = []
		var clicked_cell = local_to_map(get_local_mouse_position())
		var data = get_cell_tile_data(0, clicked_cell)
		damage_tile(GlobalVariableLoader.cellPosition, 1)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var cells = []
		var clicked_cell = local_to_map(get_local_mouse_position())
		var data = get_cell_tile_data(0, clicked_cell)
		place_lantern(GlobalVariableLoader.cellPosition)
func place_lantern(tile_position):
	
	__set_cell(tile_position)
	
func __set_cell(tile_position : Vector2):
	var zero = Vector2i(0,0)
	set_cell(2, tile_position, 1, zero, 3)
	print("cell_placed")
func damage_tile(tile_position : Vector2, damage : float):
	#set_cell(-1, GlobalVariableLoader.cellPosition)
	#_remove_cell(data)
	__destroy_tile(tile_position)

func __destroy_tile(tile_position : Vector2):
	set_cell(0, tile_position)
	
	_remove_cell(tile_position)
	
func _remove_cell(tile_position):
	var list_of_tiles = [Vector2i(tile_position.x,tile_position.y),Vector2i(tile_position.x+1,tile_position.y),
						Vector2i(tile_position.x-1,tile_position.y),Vector2i(tile_position.x,tile_position.y+1),
						Vector2i(tile_position.x+1,tile_position.y+1),Vector2i(tile_position.x-1,tile_position.y+1),
						Vector2i(tile_position.x,tile_position.y-1),Vector2i(tile_position.x+1,tile_position.y-1),
						Vector2i(tile_position.x-1,tile_position.y-1)]
	for i in list_of_tiles:
		set_cells_terrain_connect(0, list_of_tiles, 0, 1, true)
		
func save():
	var save_dict = {
		
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
	}
	return save_dict
	
