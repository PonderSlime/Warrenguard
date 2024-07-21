extends CharacterBody2D

var speed

signal jump
signal hurt
signal footstep
signal no_walk
signal death
@export var gos : CanvasLayer
@export var hud : CanvasLayer
@onready var state_machine = $AnimationTree.get("parameters/playback")
@export var jump_speed = -450
@export var gravity = 1000
@export var exit_burrow_loc : StaticBody2D
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25
@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D
@export var _anim_player : AnimationPlayer
var exit_burrow_ready : bool = false
var spawn_pos : Vector2
var is_bouncing : bool = false
# This represents the player's inertia.
var push_force = 1.0
var is_burrowing : bool = false
func _ready():
	spawn_pos = global_position
func get_input():
	# choose animation
	if velocity.length() > 0:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
func _physics_process(delta):
	if is_on_floor():
		is_bouncing = false
	if collision.disabled == false and is_burrowing == false:
		if !is_bouncing:
			velocity.y += gravity * delta
			var dir = Input.get_axis("move_left", "move_right")
			if dir != 0:
				velocity.x = lerp(velocity.x, dir * speed, acceleration)
			else:
				velocity.x = lerp(velocity.x, 0.0, friction)
		elif is_bouncing:
			velocity.y += gravity * delta
			velocity.x = lerp(velocity.x, 0.0, friction)
	elif collision.disabled == true and is_burrowing == true:
		velocity.y = 0
		velocity.x = 0
		state_machine.travel("burrow")
		if Input.is_action_just_pressed("exit_burrow") and exit_burrow_ready:
			exit_burrow_loc.visible = false
			sprite.visible = false
			global_position = exit_burrow_loc.global_position
			collision.disabled = false
			await get_tree().create_timer(0.05).timeout
			sprite.visible = true
			state_machine.travel("exit_burrow")
			is_burrowing = false
	elif collision.disabled == true and is_burrowing == false:
		velocity.y += gravity * delta
	if GlobalVariableLoader.did_just_doorway == true:
		_anim_player.play("dissolve_out")
		visible = false
		await get_tree().create_timer(0.001).timeout
		global_position = GlobalVariableLoader.door_pos
		GlobalVariableLoader.did_just_doorway = false
		await get_tree().create_timer(0.001).timeout
		visible = true
	move_and_slide()
	# after calling move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() / push_force)
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		state_machine.travel("jump")
		await get_tree().create_timer(0.1).timeout
		jump.emit()
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
			footstep.emit()
		else:
			state_machine.travel("idle")
			no_walk.emit()
	if Input.is_action_just_pressed("burrow") and is_on_floor():
		collision.disabled = true
		exit_burrow_loc.global_position = get_global_position()
		exit_burrow_loc.visible = true
		is_burrowing = true

func _process(delta):
	if GlobalVariableLoader.player_health <= 0:
		hud.visible = false
		GlobalVariableLoader.player_health = GlobalVariableLoader.start_health
		death.emit()
		collision.disabled = true
		GlobalVariableLoader.unlockCamera = true
		await get_tree().create_timer(1.5).timeout
		gos.visible = true
	if GlobalVariableLoader.reset_player_loc:
		GlobalVariableLoader.reset_player_loc = false
		position = spawn_pos
		GlobalVariableLoader.unlockCamera = false
		hud.visible = true
		collision.disabled = false
	speed = GlobalVariableLoader.player_current_movement_speed
	

func _on_exit_burrow_loc_area_entered():
	exit_burrow_ready = true


func _on_exit_burrow_loc_area_exited():
	exit_burrow_ready = false
func spike():
	velocity.y = jump_speed
	hurt.emit()
func _hurt():
	velocity.y = jump_speed/ 1.2
	hurt.emit()
	
func fungi_right():
	velocity.x += -jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
func fungi_up_right():
	velocity.y += jump_speed * 1.2
	velocity.x += -jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
func fungi_up():
	velocity.y += jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
func fungi_up_left():
	velocity.y += jump_speed * 1.2
	velocity.x += jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
func fungi_left():
	velocity.x += jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
func fungi_down_left():
	velocity.y += -jump_speed * 1.2
	velocity.x += jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
func fungi_down():
	velocity.y += -jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
func fungi_down_right():
	velocity.y += -jump_speed * 1.2
	velocity.x += -jump_speed * 1.2
	await get_tree().create_timer(0.001).timeout
	is_bouncing = true
