extends SoloPart
class_name Arm


func _init():
	move_sounds =  [
	preload("footstep-1.wav"),
	preload("footstep-2.wav"),
	preload("footstep-3.wav"),
	preload("footstep-4.wav")
	]

func turn_towards(x_direction : float):
	var head = $sprites/palm.global_position
	var tail = $sprites.global_position
	var pointing_towards = head - tail
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1
