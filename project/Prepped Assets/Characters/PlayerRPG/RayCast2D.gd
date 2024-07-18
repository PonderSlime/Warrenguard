extends RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	var collider = get_collider()
	if collider is TileMap:
		var colliderPosition = get_collision_point()
		var cellPosition: Vector2 = collider.local_to_map(colliderPosition)
		GlobalVariableLoader.cellPosition = cellPosition
		
func _input(event):
	if Input.is_action_pressed("left"):
		rotation_degrees = 90
	elif Input.is_action_pressed("right"):
		rotation_degrees = -90
	elif Input.is_action_pressed("up"):
		rotation_degrees = 180
	elif Input.is_action_pressed("down"):
		rotation_degrees = 0
