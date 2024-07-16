extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var carrot_counter = $CenterContainer/VBoxContainer/VSeparator/CarrotCounter


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_bar.value = GlobalVariableLoader.player_health
	carrot_counter.text = str(GlobalVariableLoader.carrots)
	
	
