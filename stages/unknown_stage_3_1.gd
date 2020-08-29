extends Crossroads


func _ready():
	._ready()
	EventHub.emit_signal("new_title", "the unknown")


func _on_city_scene_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://stages/city_stage_3.tscn")
