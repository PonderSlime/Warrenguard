extends CharacterBody2D

var speed = 120

signal jump
signal hurt
signal footstep
signal no_walk

@onready var state_machine = $AnimationTree.get("parameters/playback")
@export var door_pos : Node2D
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25
@export var jump_speed = -50
@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D
var spawn_pos : Vector2
# This represents the player's inertia.
var push_force = 80.0
func _ready():
	spawn_pos = global_position
func get_input():
	var current = state_machine.get_current_node()
	# choose animation
	if velocity.length() > 0:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")


func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if GlobalVariableLoader.did_just_doorway == true:
		global_position = GlobalVariableLoader.door_pos
		GlobalVariableLoader.did_just_doorway == false
	move_and_slide()
	# after calling move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() / push_force)
	# flip the character sprite left/right
	if velocity.x != 0:
		$Sprite2D.scale.x = sign(velocity.x)
	if velocity.length() > 50:
		state_machine.travel("walk")
		footstep.emit()
	else:
		state_machine.travel("idle")
		no_walk.emit()
		
func spike():
	velocity.y = jump_speed
	hurt.emit()
