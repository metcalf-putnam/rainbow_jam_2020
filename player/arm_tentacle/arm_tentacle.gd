extends Arm
var swimming := false


func _init():
	strength = 1


func get_new_animation():
	var animation_new = " "
	if swimming:
		animation_new = "swim"
	elif Input.is_action_pressed("ui_accept") and is_active:
		animation_new = "attack"
	elif is_on_floor():
		animation_new = "move" if abs(_velocity.x) > 0.1 else "idle"
	else:
		animation_new = "falling" if _velocity.y > 0 else "jump"
	animationState.travel(animation_new)
	return animation_new == "move"


func swim(boolean):
	swimming = boolean


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		EventHub.emit_signal("tentacle_touch")
