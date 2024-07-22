extends Node2D
@export var time : int = 2
@export var color_mod : CanvasModulate
@export var color_sky_mod : CanvasModulate
func load_game():
	pass
func save_game():
	pass

func _process(delta):
	if time == 2:
		color_mod.color = Color(1,1,1)
		color_sky_mod.color = Color(1,1,1)
	elif time == 0:
		color_mod.color = Color(0.25,0.25,0.25)
		color_sky_mod.color = Color(0.25,0.25,0.25)
		
