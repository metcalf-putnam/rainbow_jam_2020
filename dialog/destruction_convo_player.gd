extends DialogPlayer 
export var deep_thought : String
export var thought : String
var previous_state
var started := false

signal repeating_thought

func _ready():
	EventHub.connect("destruction", self, "_on_destruction")


func _on_destruction(_strength):
	if Global.cora_met_in_present_form and !started:
		print("okay then!")
		started = true
		yield(get_tree().create_timer(5), "timeout")
		EventHub.emit_signal("dialogue_started", self)


func _on_FirstDestructionConvo_dialog_finished():
	start_deep_thought()


func start_deep_thought():
	yield(get_tree().create_timer(.5), "timeout")
	previous_state = Transition.get_ui_state()
	EventHub.emit_signal("memory_scene")
	yield(EventHub, "ui_changed")
	EventHub.emit_signal("deep_thought_started", deep_thought)
	EventHub.connect("deep_thought_finished", self, "_on_deep_thought_finished")


func _on_deep_thought_finished():
	if previous_state == "normal":
		EventHub.emit_signal("normal_scene")
	yield(get_tree().create_timer(2), "timeout")
	EventHub.emit_signal("thought_started", thought)
	emit_signal("repeating_thought")
	queue_free()
		

