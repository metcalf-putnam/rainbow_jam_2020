extends Area2D




func _on_WaterTrigger_body_entered(body):
	if body.is_in_group("player"):
		body.swim(true)


func _on_WaterTrigger_body_exited(body):
	if body.is_in_group("player"):
		body.swim(false)
