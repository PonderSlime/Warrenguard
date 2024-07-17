extends CharacterBody2D

var move_speed = 100
@export var patrol_path : NodePath
var patrol_points
var patrol_index = 0

func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func _physics_process(float) -> void:
	if !patrol_path:
		return
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 1:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	velocity = (target - position).normalized() * move_speed
	move_and_slide()
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		GlobalVariableLoader.player_health -= 1
		body.spike()
