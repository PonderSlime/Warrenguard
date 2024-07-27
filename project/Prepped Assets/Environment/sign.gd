extends Node2D

@export var label = "test"
@export var is_flipped : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_flipped:
		$Sign.scale.x = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

pass # Replace with function body.
func _on_area_2d_body_entered(body):
	if body.name == "PlayerRPG":
		$PopupBackground.visible = true
		


func _on_area_2d_body_exited(body):
	if body.name == "PlayerRPG":
		$PopupBackground.visible = false
