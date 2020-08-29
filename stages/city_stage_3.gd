extends City
var true_ending := false
var ending_started := false


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	EventHub.connect("hugged", self, "_on_cora_hugged")
	EventHub.connect("town_halved", self, "_on_town_half_health")
	EventHub.connect("town_quartered", self, "_on_town_quarter_health")


func _on_town_half_health():
	EventHub.emit_signal("dialogue_started", $HalfHealthConvo)


func _on_town_quarter_health():
	EventHub.emit_signal("dialogue_started", $QuarterHealthConvo)


func _on_scene_change_trigger_body_entered(_body):
	EventHub.emit_signal("thought_started", "we can't leave without Cora")


func _on_Area2D_body_entered(_body):
	true_ending = true
	if ending_started:
		return
	EventHub.emit_signal("dialogue_started", $TrueEndingConvo)
	ending_started = true


func _on_TrueEndingConvo_dialog_finished():
	EventHub.emit_signal("start_hug")


func _on_cora_hugged():
	if true_ending:
		EventHub.emit_signal("good_ending")
		Transition.fade_to_black()
	else:
		EventHub.emit_signal("bad_ending")
		Transition.change_scene("res://stages/BadEnding.tscn")


func _on_town_destroyed():
	$Timer.stop()
	if ending_started:
		return
	ending_started = true
	$buildings/StaticBody2D7.set_collision_mask_bit(0, false)
	$RigidBody2D.set_sleeping(false)
	yield(get_tree().create_timer(2.9), "timeout")
	EventHub.emit_signal("dialogue_started", $FalseEndingConvo)


func _on_FalseEndingConvo_dialog_finished():
	EventHub.emit_signal("start_hug")
	$Player.new_main_piece("hand")


func _on_FirstConvoTrigger_body_entered(body):
	if Global.cora_met_in_present_form:
		return
	EventHub.emit_signal("dialogue_started", $FirstMedusaConvo)
	Global.cora_met_in_present_form = true
