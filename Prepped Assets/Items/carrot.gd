extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	GlobalVariableLoader.carrots += 1
	GlobalVariableLoader.player_health += 1
	print(GlobalVariableLoader.carrots)
	await get_tree().create_timer(0.01).timeout
	GlobalVariableLoader.prev_carrots = GlobalVariableLoader.carrots
	queue_free()
