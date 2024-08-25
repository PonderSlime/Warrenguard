extends Control
var build_item : int = 0
func _process(delta):
		GlobalVariableLoader.build_item = build_item
func _on_radial_menu_hovered(child):
	#prints("Hovered", child)
	pass


func _on_radial_menu_selected(child):
	#prints("Selected", child)
	pass


func _on_texture_button_8_pressed():
	build_item = 1
	


func _on_texture_button_12_pressed():
	build_item = 2


func _on_texture_button_13_pressed():
	build_item = 3


func _on_texture_button_9_pressed():
	build_item = 4


func _on_texture_button_10_pressed():
	build_item = 5


func _on_texture_button_11_pressed():
	build_item = 6
