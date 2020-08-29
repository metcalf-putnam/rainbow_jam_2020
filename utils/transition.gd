extends CanvasLayer


func change_scene(scene_path : String):
	$AnimationPlayer.play("fade") # play the transition animation
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(scene_path) == OK)
	$AnimationPlayer.play_backwards("fade")
	
func get_ui_state():
	return $UI_Layer.state
	

func fade_to_black():
	print("fading")
	$AnimationPlayer.play("fade")
