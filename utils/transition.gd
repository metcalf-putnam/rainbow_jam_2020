extends CanvasLayer


func change_scene(scene_path : String):
	$AnimationPlayer.play("fade") # play the transition animation
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(scene_path) == OK)
	$AnimationPlayer.play_backwards("fade")
