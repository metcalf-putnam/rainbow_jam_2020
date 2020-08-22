extends Area2D
export var deep_thought : String
export var id : String
var previous_state

func _on_DeepThoughtTrigger_body_entered(body):
	if !body.is_in_group("player"):
		return
	EventHub.emit_signal("change_player_active_state", false)
	previous_state = Transition.get_ui_state()
	EventHub.emit_signal("memory_scene")
	yield(EventHub, "ui_changed")
	EventHub.emit_signal("deep_thought_started", deep_thought)
	EventHub.connect("deep_thought_finished", self, "_on_deep_thought_finished")

func _on_deep_thought_finished():
	if previous_state == "normal":
		EventHub.emit_signal("normal_scene")
	EventHub.emit_signal("change_player_active_state", true)
	#queue_free()
