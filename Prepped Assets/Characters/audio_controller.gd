extends Node

@export var song : AudioStreamPlayer
@export var sound_effects : AudioStreamPlayer
@export var walk_sound : AudioStreamPlayer
var overworld = preload("res://Audio/Music/overworld.wav")
var jump = preload("res://Audio/Sound Effects/jump.wav")
var hurt = preload("res://Audio/Sound Effects/hurt.wav")
var coin = preload("res://Audio/Sound Effects/point.wav")
var footstep = preload("res://Audio/Sound Effects/footstep.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !song.is_playing():
		song.stream_paused = false
		song.stream = overworld
		song.play()
	if GlobalVariableLoader.prev_carrots != GlobalVariableLoader.carrots:
		_point()
	if sound_effects.is_playing():
		_no_walk()

func _jump():
	sound_effects.stream = jump
	sound_effects.play()
	return
func _hurt():
	sound_effects.stream = hurt
	sound_effects.play()
	return
func _point():
	sound_effects.stream = coin
	sound_effects.play()
	return
func _walk():
	if !walk_sound.is_playing() and !sound_effects.is_playing():
		walk_sound.stream = footstep
		walk_sound.play()
func _no_walk():
		walk_sound.stop()
