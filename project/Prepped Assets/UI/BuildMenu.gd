extends Control

func _process(delta):
	print(GlobalVariableLoader.active_build_item)
func _on_radial_menu_hovered(child):
	prints("Hovered", child)


func _on_radial_menu_selected(child):
	prints("Selected", child)


func _on_texture_button_8_pressed():
	GlobalVariableLoader.active_build_item = 1
	


func _on_texture_button_12_pressed():
	GlobalVariableLoader.active_build_item = 2


func _on_texture_button_13_pressed():
	GlobalVariableLoader.active_build_item = 3


func _on_texture_button_9_pressed():
	GlobalVariableLoader.active_build_item = 4


func _on_texture_button_10_pressed():
	GlobalVariableLoader.active_build_item = 5


func _on_texture_button_11_pressed():
	GlobalVariableLoader.active_build_item = 6
