extends Node2D
@export var background_type : int = 2
@export var color_mod : CanvasModulate
@export var color_sky_mod : CanvasModulate
@export var lights : Sprite2D
@export var point_light : PointLight2D
@export var background : Sprite2D
@export var clouds : Node2D
@onready var day = preload("res://Sprites/Environment/Background1.png")
@onready var night = preload("res://Sprites/Environment/NightBackground.png")
@onready var lava = preload("res://Sprites/Environment/LavaBackground.png")

@onready var stars = preload("res://Sprites/Environment/NightBackgroundLights.png")
@onready var lavalight = preload("res://Sprites/Environment/LavaBackgroundLights.png")
func load_game():
	pass
func save_game():
	pass

func _process(delta):
	if background_type == 2:
		clouds.visible = true
		background.texture = day
		color_mod.color = Color(1,1,1)
		color_sky_mod.color = Color(1,1,1)
		lights.visible = false
		lights.texture = stars
		point_light.texture = stars
	
	elif background_type == 0:
		clouds.visible = true
		background.texture = night
		color_mod.color = Color(0.25,0.25,0.25)
		color_sky_mod.color = Color(0.25,0.25,0.25)
		lights.visible = true
		lights.texture = stars
		point_light.texture = stars
	elif background_type == -1:
		clouds.visible = false
		background.texture = lava
		color_mod.color = Color(0.4,0.4,0.4)
		color_sky_mod.color = Color(0.5,0.5,0.5)
		lights.visible = true
		lights.texture = lavalight
		point_light.texture = lavalight
		
