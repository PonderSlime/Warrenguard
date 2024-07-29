extends CanvasLayer

var build_menu : bool = false

func _process(delta):
	if Input.is_action_just_pressed("build_menu"):
		build_menu = !build_menu
	
	if build_menu:
		$BuildMenu.visible = true
	elif !build_menu:
		$BuildMenu.visible = false


func _on_radial_menu_selected(child):
	print("select!")
	build_menu = false
