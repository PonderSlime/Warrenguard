extends StaticBody2D

var in_range : bool = false
var reading : bool = false
@export var inventory : TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
			
	if !reading:
		inventory.visible = false
		GlobalVariableLoader.is_frozen = false
	elif reading:
		$PopupBackground.visible = false
		inventory.visible = true
		GlobalVariableLoader.is_frozen = true

func _on_input_event(viewport, event, shape_idx):
	if(event.is_pressed()):
		print("pressed!")


func _on_area_2d_body_entered(body):
	if body.name == "PlayerRPGDigger":
		$PopupBackground.visible = true
		in_range = true


func _on_area_2d_body_exited(body):
	if body.name == "PlayerRPGDigger":
		$PopupBackground.visible = false
		in_range = false	


func _on_button_pressed():
	reading = !reading
	print("inventory")
