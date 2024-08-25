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
		if GlobalVariableLoader.build_item == 6:
			damage_tile(GlobalVariableLoader.cellPosition, 1)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var cells = []
		var clicked_cell = local_to_map(get_local_mouse_position())
		var data = get_cell_tile_data(0, clicked_cell)
		place_lantern(GlobalVariableLoader.player_tile_pos)
func place_lantern(tile_position):
	
	__set_cell(tile_position)
	
func __set_cell(tile_position : Vector2):
	var zero = Vector2i(0,0)
	
	if GlobalVariableLoader.build_item == 1:
		set_cell(3, tile_position, 1, zero, 3)
	elif GlobalVariableLoader.build_item == 2:
		set_cell(3, tile_position, 1, zero, 1)
	elif GlobalVariableLoader.build_item == 3:
		if get_cell_source_id(0, Vector2i(tile_position.x,tile_position.y)) == -1:
			set_cell(2, tile_position, 0, Vector2i(1,4), 0)
			_build_room(tile_position)
	elif GlobalVariableLoader.build_item == 4:
		if get_cell_source_id(0, Vector2i(tile_position.x,tile_position.y)) == -1:
			set_cell(2, tile_position, 0, Vector2i(1,4), 0)
	elif GlobalVariableLoader.build_item == 5:
		set_cell(3, tile_position, 1, Vector2i(-1,-1))
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
func _build_room(tile_position):
	var list_of_tiles = [Vector2i(tile_position.x,tile_position.y),Vector2i(tile_position.x+1,tile_position.y),
						Vector2i(tile_position.x-1,tile_position.y),Vector2i(tile_position.x,tile_position.y+1),
						Vector2i(tile_position.x+1,tile_position.y+1),Vector2i(tile_position.x-1,tile_position.y+1),
						Vector2i(tile_position.x,tile_position.y-1),Vector2i(tile_position.x+1,tile_position.y-1),
						Vector2i(tile_position.x-1,tile_position.y-1)]
	
	for i in list_of_tiles:
		if get_cell_source_id(0, i) == -1:
			set_cells_terrain_connect(2, list_of_tiles, 1, 0, true)
		
func save():
	var save_dict = {
		
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
	}
	return save_dict
	
