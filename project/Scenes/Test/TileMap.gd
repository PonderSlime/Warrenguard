extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if Input.is_action_pressed("exit_burrow"):
		get_clicked_tile_power()

func get_clicked_tile_power():
	var clicked_cell = local_to_map(get_local_mouse_position())
	var data = get_cell_tile_data(0, clicked_cell)
	
	if data:
		set_cell(-1, GlobalVariableLoader.cellPosition)
	else:
		return 0
	
