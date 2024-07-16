extends Node

@export var song : AudioStreamPlayer
@export var sound_effects : AudioStreamPlayer
var overworld = preload("res://Audio/Music/overworld.wav")
var jump = preload("res://Audio/Sound Effects/jump.wav")
var hurt = preload("res://Audio/Sound Effects/hurt.wav")
var coin = preload("res://Audio/Sound Effects/point.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !song.is_playing():
		song.stream = overworld
		song.play()
	if GlobalVariableLoader.prev_carrots != GlobalVariableLoader.carrots:
		_point()

func _jump():
	sound_effects.stream = jump
	sound_effects.play()
func _hurt():
	sound_effects.stream = hurt
	sound_effects.play()
func _point():
	sound_effects.stream = coin
	sound_effects.play()
