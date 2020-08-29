extends Crossroads


func _ready():
	$Player.set_camera_current()
	EventHub.connect("hugged", self, "_on_frankie_hugged")
	EventHub.emit_signal("new_title", "the unknown")


func _on_city_scene_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://stages/city_stage_1.tscn")


func _on_ConvoTrigger_body_exited(body):
	if body.is_in_group("player"):
		EventHub.emit_signal("dialogue_started", $DialogPlayer)


func _on_frankie_hugged():
	yield(get_tree().create_timer(.5), "timeout")
	$Player.new_main_piece("hand_tentacle")
	Transition.call_deferred("change_scene", "res://mini_games/frankie/frankie_game.tscn")
