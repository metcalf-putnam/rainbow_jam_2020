extends Area2D



func _on_CoraConvo_body_entered(body):
	if body.is_in_group("player"):
		EventHub.emit_signal("dialogue_started", $FirstMeeting)
		Global.cora_met_in_present_form = true

func _on_FirstMeeting_dialog_finished():
	queue_free()
