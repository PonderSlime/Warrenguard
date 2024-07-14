extends CharacterBody2D

var run_speed = 80.0
var attacks = ["attack1", "attack2"]

@onready var state_machine = $AnimationTree["parameters/playback"]
@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25
#func hurt():
	#state_machine.travel("hurt")
#
#func die():
	#state_machine.travel("die")
	#set_physics_process(false)

func get_input():
	var current = state_machine.get_current_node()
	# flip the character sprite left/right
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	# choose animation
	if velocity.length() > 0:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
	move_and_slide()

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("move_left", "move_right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		state_machine.travel("jump")
	if velocity.y < 0:
		state_machine.travel("fall")
	if is_on_floor():
		state_machine.travel("land")
