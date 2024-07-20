extends RayCast2D

@onready var light = $PointLight2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left"):
		rotation_degrees = 90
		position.y = -10
		light.position.y = 22.5
	elif Input.is_action_pressed("right"):
		rotation_degrees = -90
		position.y = -10
		light.position.y = 22.5
	elif Input.is_action_pressed("up"):
		rotation_degrees = 180
		position.y = -22
		light.position.y = 16
	elif Input.is_action_pressed("down"):
		rotation_degrees = 0
		position.y = 1
		light.position.y = 15
	var collider = get_collider()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if collider is TileMap:
			var colliderPosition = get_collision_point()
			var cellPosition: Vector2 = collider.local_to_map(colliderPosition)
			GlobalVariableLoader.cellPosition = cellPosition
	
