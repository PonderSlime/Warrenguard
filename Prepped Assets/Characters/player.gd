extends CharacterBody2D

var run_speed = 8.9

@onready var state_machine = $AnimationTree.get("parameters/playback")
@export var speed = 120
@export var jump_speed = -450
@export var gravity = 1000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

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
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		state_machine.travel("jump")
		await get_tree().create_timer(0.1).timeout
		velocity.y = jump_speed
		
		return
	if velocity.y < 0:
		state_machine.travel("fall")
		return
	if is_on_floor():
		if !is_on_floor():
			state_machine.travel("land")
			return
		if velocity.length() > 50:
			state_machine.travel("walk")
		else:
			state_machine.travel("idle")
