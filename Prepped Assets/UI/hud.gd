extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var carrot_counter = $CenterContainer/PanelContainer/VSeparator/CarrotCounter
@onready var carrot = $CenterContainer/PanelContainer/VSeparator/Carrot
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_bar.value = GlobalVariableLoader.player_health
	carrot_counter.text = str(" X ", GlobalVariableLoader.carrots)
	
