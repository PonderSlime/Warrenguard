extends Node2D

@export var is_flipped : bool = false
@export var sign_content : TileMap
@export var label = "String"
var in_range : bool = false
var reading : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_flipped:
		$Sign.scale.x = -1
	$TextDialog/Label2.text = label
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_range:
		if Input.is_action_just_pressed("read"):
			reading = !reading
			
	if !reading:
		sign_content.visible = false
		GlobalVariableLoader.is_frozen = false
	elif reading:
		$PopupBackground.visible = false
		sign_content.visible = true
		GlobalVariableLoader.is_frozen = true

func _on_area_2d_body_entered(body):
	if body.name == "PlayerRPG":
		$PopupBackground.visible = true
		in_range = true
		


func _on_area_2d_body_exited(body):
	if body.name == "PlayerRPG":
		$PopupBackground.visible = false
		in_range = false
