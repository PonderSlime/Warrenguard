extends CanvasLayer

var build_menu : bool = false

func _process(delta):
	if Input.is_action_just_pressed("build_menu"):
		build_menu = !build_menu
	
	if build_menu:
		$BuildMenu/RadialMenu.visible = true
	elif !build_menu:
		$BuildMenu/RadialMenu.visible = false


func _on_radial_menu_selected(child):
	build_menu = false
