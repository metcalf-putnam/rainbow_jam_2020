extends Area2D

export var thought : String


func _on_ThoughtTrigger_body_entered(body):
	if !body.is_in_group("player"):
		return
	EventHub.emit_signal("thought_started", thought)
	#queue_free()
