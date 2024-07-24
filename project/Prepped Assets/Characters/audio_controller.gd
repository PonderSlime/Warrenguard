extends Node

@export var song : AudioStreamPlayer
@export var sound_effects : AudioStreamPlayer
@export var walk_sound : AudioStreamPlayer
@export var powerup_sound : AudioStreamPlayer
var overworld = preload("res://Audio/Music/overworld.wav")
var dreadful = preload("res://Audio/Music/dreadful.wav")
var wonderful = preload("res://Audio/Music/wonderful.wav")
var powerup_music = preload("res://Audio/Music/powerup.wav")
var game_over = preload("res://Audio/Music/gameover.wav")
var jump = preload("res://Audio/Sound Effects/jump.wav")
var hurt = preload("res://Audio/Sound Effects/hurt.wav")
var coin = preload("res://Audio/Sound Effects/point.wav")
var footstep = preload("res://Audio/Sound Effects/footstep.wav")
var death = preload("res://Audio/Sound Effects/death.wav")
var powerup_start = preload("res://Audio/Sound Effects/powerup_start.wav")
var powerup_end = preload("res://Audio/Sound Effects/powerup_end.wav")

func _process(delta):
	if GlobalVariableLoader.current_power_up == 1 and GlobalVariableLoader.prev_power_up == 0:
		song.stop()
		sound_effects.stop()
		powerup_sound.stream = powerup_start
		powerup_sound.play()
	elif GlobalVariableLoader.current_power_up == 1 and GlobalVariableLoader.prev_power_up == 1 and GlobalVariableLoader.unlockCamera == false:
		if !song.is_playing():
				song.stream = powerup_music
				song.play()
	elif GlobalVariableLoader.current_power_up == 0 and GlobalVariableLoader.prev_power_up == 1 and GlobalVariableLoader.unlockCamera == false:
		print(GlobalVariableLoader.prev_power_up)
		powerup_sound.stream = powerup_end
		powerup_sound.play()
	elif GlobalVariableLoader.current_power_up == 0 and GlobalVariableLoader.prev_power_up == 0 and GlobalVariableLoader.active_level == 0 and GlobalVariableLoader.unlockCamera == false:
		if !song.is_playing():
			song.stream = wonderful
			song.play()
	elif GlobalVariableLoader.current_power_up == 0 and GlobalVariableLoader.prev_power_up == 0 and GlobalVariableLoader.active_level == 1 and GlobalVariableLoader.unlockCamera == false:
		if !song.is_playing():
			song.stream = overworld
			song.volume_db
			song.play()
	elif GlobalVariableLoader.current_power_up == 0 and GlobalVariableLoader.prev_power_up == 0 and GlobalVariableLoader.active_level == 2 and GlobalVariableLoader.unlockCamera == false:
		if !song.is_playing():
			song.stream = dreadful
			song.play()
	
	
	#elif GlobalVariableLoader.unlockCamera == true:
		#song.stop()
		#_gameover()
	if GlobalVariableLoader.prev_carrots != GlobalVariableLoader.carrots:
		_point()
		GlobalVariableLoader.prev_carrots = GlobalVariableLoader.carrots
	
	if sound_effects.is_playing():
		_no_walk()
func _musicStop():
	song.stop()
func _gameover():
	song.stream = game_over
	song.play()
func _jump():
	sound_effects.stream = jump
	sound_effects.play()
	return
func _hurt():
	if GlobalVariableLoader.player_health > 0:
		sound_effects.stream = hurt
		sound_effects.play()
	elif GlobalVariableLoader.player_health <= 0:
		sound_effects.stream = death
		sound_effects.play()
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
