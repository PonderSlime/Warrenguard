extends Area2D

@export var speed = 150

func start(pos):
	position = pos

func _process(delta):
	#position.y += speed * delta
	position += transform.x * speed * delta
	$Sprite2D.rotation += 0.25
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		GlobalVariableLoader.player_health -= 1
		body._hurt()
		queue_free()
