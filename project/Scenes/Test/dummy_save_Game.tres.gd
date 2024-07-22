extends Node2D
@export var time : int = 2
@export var color_mod : CanvasModulate
@export var color_sky_mod : CanvasModulate
@export var night_lights : Sprite2D
@export var background_day : Sprite2D
@export var background_night : Sprite2D
func load_game():
	pass
func save_game():
	pass

func _process(delta):
	if GlobalVariableLoader.player_health < 2:
		time = 0
	else:
		time = 2
	if time == 2:
		background_day.visible = true
		background_night.visible = false
		color_mod.color = Color(1,1,1)
		color_sky_mod.color = Color(1,1,1)
		night_lights.visible = false
	
	elif time == 0:
		background_night.visible = true
		background_day.visible = false
		color_mod.color = Color(0.25,0.25,0.25)
		color_sky_mod.color = Color(0.25,0.25,0.25)
		night_lights.visible = true
		
