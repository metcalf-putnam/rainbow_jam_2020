extends Crossroads
var found := false

func _ready():
	._ready()
	EventHub.connect("tentacle_touch", self, "_on_tiffany_found")
	EventHub.connect("hugged", self, "_on_tiffany_hugged")
	EventHub.emit_signal("new_title", "the unknown")


func _on_city_scene_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://stages/city_stage_.tscn")


func _on_tiffany_found():
	if found:
		return
	else:
		EventHub.emit_signal("dialogue_started", $TiffanyConvo)
		found = true


func _on_tiffany_hugged():
	yield(get_tree().create_timer(.5), "timeout")
	$Player.new_main_piece("medusa")
	Transition.call_deferred("change_scene", "res://mini_games/tiffany/tiffany_game.tscn")


func _on_TiffanyConvo_dialog_finished():
	EventHub.emit_signal("start_hug")
