extends Node2D

var scene_name := "crossroads"


func _ready():
	$Player.set_camera_current()
	EventHub.connect("hugged", self, "_on_frankie_hugged")


func _on_city_scene_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://stages/city_stage_1.tscn")


func _on_CrossroadsTrigger_body_entered(body):
	if body.is_in_group("player"):
		EventHub.emit_signal("new_title", scene_name)


func _on_ConvoTrigger_body_exited(body):
	if body.is_in_group("player"):
		EventHub.emit_signal("dialogue_started", $DialogPlayer)


func _on_DialogPlayer_dialog_finished():
	EventHub.emit_signal("start_hug")


func _on_frankie_hugged():
	$Player.new_main_piece("hand_tentacle")
	yield(get_tree().create_timer(1), "timeout")
	Transition.change_scene("res://mini_games/frankie/frankie_game.tscn")
