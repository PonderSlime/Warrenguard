extends Node2D
@export var tilemap : TileMap
@onready var player = $PlayerRPGDigger
var cellPos : Vector2
var lamp : bool = false
@export var lamp_obj : PointLight2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = Vector2(player.global_position.x,player.global_position.y - 16)
	cellPos = tilemap.local_to_map(pos)
	GlobalVariableLoader.player_tile_pos = cellPos
	if Input.is_action_just_pressed("toggle_light"):
		lamp = !lamp
		
	if lamp:
		lamp_obj.visible = true
	elif !lamp:
		lamp_obj.visible = false
