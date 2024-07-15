extends StaticBody2D
var direction
@export var speed = 10

func _ready():
	pass # Replace with function body.

func _physics_process(_dt: float) -> void:
	var new_position = position
	if position != get_global_mouse_position():
		new_position = lerp(position, get_global_mouse_position(), .1)
	move_and_collide(new_position - position)  # relative position vector
