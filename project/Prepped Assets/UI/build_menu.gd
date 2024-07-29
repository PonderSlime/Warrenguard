extends CanvasLayer

var build_menu : bool = false

func _process(delta):
	if Input.is_action_just_pressed("build_menu"):
		build_menu = true
	if build_menu:
		$BuildMenu.visible = true
		$BuildMenu.process_mode = 1
	elif !build_menu:
		$BuildMenu.visible = false
		$BuildMenu.process_mode = 4

func _on_radial_menu_selected(child):
	await get_tree().create_timer(0.01).timeout
	build_menu = false
