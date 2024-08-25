extends StaticBody2D
var direction
@export var collision : Area2D
signal area_entered
signal area_exited
@onready var ray = $RayCast2D
func _ready():
	pass # Replace with function body.

func _physics_process(_dt: float) -> void:
	var new_position = position
	if position != get_global_mouse_position():
		new_position = lerp(position, get_global_mouse_position(), 1)
	move_and_collide(new_position - position)  # relative position vector
	
	#if collision.is_colliding():
		#print("colliding")


func _on_area_2d_body_entered(body):
	if ray.is_colliding():
		area_entered.emit()


func _on_area_2d_body_exited(body):
	area_exited.emit()
