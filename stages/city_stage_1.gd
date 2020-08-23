extends City


func _on_scene_change_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://stages/unknown_stage_1_2.tscn")		
