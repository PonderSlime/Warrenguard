extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var carrot_counter = $CenterContainer/VBoxContainer/VSeparator/CarrotCounter
@export var carrot_count_type : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.value = GlobalVariableLoader.start_health
	health_bar.max_value = GlobalVariableLoader.start_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_bar.value = GlobalVariableLoader.player_health
	if carrot_count_type == 0:
		carrot_counter.text = str(GlobalVariableLoader.carrots)
	elif carrot_count_type == 1 :
		carrot_counter.text = str(GlobalVariableLoader.stored_carrots)
