extends Area2D

export var thought : String
export var one_time = true


func _on_ThoughtTrigger_body_entered(body):
	if !body.is_in_group("player"):
		return
	EventHub.emit_signal("thought_started", thought)
	if one_time:
		queue_free()
