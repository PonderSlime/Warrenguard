extends StaticBody2D

var projectile1_scene = preload("res://Prepped Assets/Characters/Enemies/enemy_projectile_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(GlobalVariableLoader.player_pos)

func _on_shoot_timer_timeout():
	print("timeout!")
	var b = projectile1_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position)
	b.transform = global_transform
	$ShootTimer.wait_time = randf_range(4, 10)
	$ShootTimer.start()
