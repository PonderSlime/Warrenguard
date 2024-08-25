extends StaticBody2D
@export var head : Sprite2D
@export var headAnim : AnimationPlayer
@export var area : Area2D
var continue_timer : bool = false
var continue_shoot : bool = false
var projectile1_scene = preload("res://Prepped Assets/Characters/Enemies/enemy_projectile_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if continue_timer:
		head.look_at(GlobalVariableLoader.player_pos)
		continue_shoot = true
	elif !continue_timer:
		head.rotation_degrees = -90
		headAnim.play("RESET")
		continue_shoot = false
func _on_shoot_timer_timeout():
	if continue_shoot:
		headAnim.play("belch_proj")
		$AudioStreamPlayer2D.play()
		var b = projectile1_scene.instantiate()
		get_tree().root.add_child(b)
		b.start(head.position)
		b.transform = head.global_transform
	$ShootTimer.wait_time = randf_range(4, 10)
	$ShootTimer.start()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		continue_timer = true
func _on_area_2d_body_exited(body):
	continue_timer = false
