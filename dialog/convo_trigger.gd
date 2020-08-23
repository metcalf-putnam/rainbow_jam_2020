extends Area2D



func _on_ConvoTrigger_body_entered(body):
	if body.is_in_group("player"):
		EventHub.emit_signal("dialogue_started", body, $DialogPlayer)
