extends RayCast2D

var ray2 : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray2:
		var collider = get_collider()
		if collider is TileMap:
			var colliderPosition = get_collision_point()
			var cellPosition: Vector2 = collider.local_to_map(colliderPosition)
			GlobalVariableLoader.cellPosition = cellPosition


func _on_ray_casts_ray_2():
	ray2 = true


func _on_ray_casts_noray_2():
	ray2 = false
