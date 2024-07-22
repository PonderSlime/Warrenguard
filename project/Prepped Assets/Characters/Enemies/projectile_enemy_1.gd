extends StaticBody2D

var Player : CharacterBody2D
var projectile1_scene = preload("res://Prepped Assets/Characters/Enemies/enemy_projectile_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(player.global_position)

func _on_shoot_timer_timeout():
	var b = projectile1_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position)
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()
