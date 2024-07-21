extends StaticBody2D

var fungi = self
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _physics_process(_delta):
	pass


func _on_area_2d_body_entered(body):
		if fungi.rotation == 90:
			if body.name == "Player":
				print("test")
				body.fungi_right()
		elif fungi.rotation == 45:
			if body.name == "Player":
				print("test")
				body.fungi_up_right()
		elif fungi.rotation == 0:
			if body.name == "Player":
				print("test")
				body.fungi_up()
		elif fungi.rotation == -45:
			if body.name == "Player":
				print("test")
				body.fungi_up_left()
		elif fungi.rotation == -90:
			if body.name == "Player":
				print("test")
				body.fungi_left()
		elif fungi.rotation == -135:
			if body.name == "Player":
				print("test")
				body.fungi_down_left()
		elif fungi.rotation == -180:
			if body.name == "Player":
				print("test")
				body.fungi_down()
		elif fungi.rotation == -225:
			if body.name == "Player":
				print("test")
				body.fungi_down_right()
		
