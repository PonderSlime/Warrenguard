

extends Camera2D
 
# Use this value to compensate for your project's resolution
# 2.4 is appropriate for 1080p. 1.0 is appropriate for 480p
const SCALE := 1.2
 
 
@export_category("pan")
 
@export var threshold := 390.0 * SCALE
@export var pan := 0.05 * SCALE
@export var horizontal_margin := 200.0 * SCALE
@export var vertical_margin := 300.0 * SCALE
 
@export var center_rate := 1.06 #TODO: replace with bezier curve-like movement; or smoother whatever
@export var retreat_multiplier := 1.1
 
 
@export_category("zoom")
 
@export var v_zoom_threshold := 400.0 * SCALE
@export var v_zoom_factor := 400.0 * SCALE
@export var zoom_out_rate := 0.05
@export var zoom_in_rate := 0.005
@export var zoom_roundoff := .999
 
 
@onready var target : CharacterBody2D = get_parent()
 
@onready var viewport_size := get_viewport_rect().size
 
# States
@onready var target_last_pos := target.position
func _process(delta : float):
	var d := target_last_pos - target.position
	
	## ELASTIC
	var zoom_targ := 1 / clampf(target.velocity.length() / v_zoom_factor, 1.0, 3.0)
	var zoom_diff = (zoom - Vector2(zoom_targ, zoom_targ)).length() ** 3
	var zoom_rate := zoom_out_rate
	if zoom_targ > zoom.x:
		zoom_rate = zoom_in_rate
	if zoom_targ > zoom_roundoff:
		zoom = zoom.move_toward(Vector2(zoom_targ, zoom_targ), zoom_rate)
	else:
		zoom = zoom.move_toward(Vector2(zoom_targ, zoom_targ), zoom_rate * zoom_diff)
	
	## PUSH AHEAD
	position.x = component_tf(position.x, d.x, viewport_size.x-horizontal_margin, delta)
	position.y = component_tf(position.y, d.y, viewport_size.y-vertical_margin, delta)
	target_last_pos = target.position
 
# Transpose one component
func component_tf(component : float, diff : float, margin : float, delta: float):
	if abs(diff/delta) > threshold:
		# must push in front of parent. Parent moves so we don't think we're moving, move opposite from parent.
		# velocity is less than target for a time until it's going too fast
		var adjustment = (diff * pan)
		if component * adjustment < 0.0:
			component -= adjustment * retreat_multiplier
		else:
			component -= adjustment
		return clamp(component, -margin, margin)
	else:
		#below a certain vel, reset to center
		return component / center_rate
