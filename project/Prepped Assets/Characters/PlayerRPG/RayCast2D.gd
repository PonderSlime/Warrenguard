extends Node
@export var ray_01 : RayCast2D
@export var ray_02 : RayCast2D
@export var ray_03 : RayCast2D
var active
signal ray1
signal ray2
signal ray3
signal noray1
signal noray2
signal noray3
func _process(delta):
	if Input.is_action_pressed("left"):
		ray_02.enabled = false
		ray_02.force_raycast_update()
		#ray_02.visible = false
		ray_03.enabled = false
		ray_03.force_raycast_update()
		#ray_03.visible = false
		ray_01.enabled = true
		ray_01.force_raycast_update()
		#ray_01.visible = true
		ray_01.rotation_degrees = 90
		active = ray_01
	elif Input.is_action_pressed("right"):
		ray_02.enabled = false
		ray_02.force_raycast_update()
		#ray_02.visible = false
		ray_03.enabled = false
		ray_03.force_raycast_update()
		#ray_03.visible = false
		ray_01.enabled = true
		ray_01.force_raycast_update()
		#ray_01.visible = true
		ray_01.rotation_degrees = -90
		active = ray_01
	elif Input.is_action_pressed("up"):
		ray_01.enabled = false
		ray_01.force_raycast_update()
		#ray_01.visible = false
		ray_03.enabled = false
		ray_03.force_raycast_update()
		#ray_03.visible = false
		ray_02.enabled = true
		ray_02.force_raycast_update()
		#ray_02.visible = true
		active = ray_02
	elif Input.is_action_pressed("down"):
		ray_01.enabled = false
		ray_01.force_raycast_update()
		#ray_01.visible = false
		ray_02.enabled = false
		ray_02.force_raycast_update()
		#ray_02.visible = false
		ray_03.enabled = true
		ray_03.force_raycast_update()
		#ray_03.visible = true
		active=ray_03
		#print("colliding at: ", cellPosition)
	if active == ray_01:
		ray1.emit()
		noray2.emit()
		noray3.emit()
		#var collider = ray_01.get_collider()
		#if collider is TileMap:
			#var colliderPosition = ray_01.get_collision_point()
			#var cellPosition: Vector2 = collider.local_to_map(colliderPosition)
			#GlobalVariableLoader.cellPosition = cellPosition
	elif active == ray_02:
		ray2.emit()
		noray1.emit()
		noray3.emit()
		#var collider = ray_02.get_collider()
		#if collider is TileMap:
			#var colliderPosition = ray_02.get_collision_point()
			#var cellPosition: Vector2 = collider.local_to_map(colliderPosition)
			#GlobalVariableLoader.cellPosition = cellPosition
	elif active == ray_03:
		ray3.emit()
		noray1.emit()
		noray2.emit()
		#var collider = ray_03.get_collider()
		#if collider is TileMap:
			#var colliderPosition = ray_03.get_collision_point()
			#var cellPosition: Vector2 = collider.local_to_map(colliderPosition)
	
