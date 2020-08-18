extends SoloPart



func turn_towards(x_direction : float):
	var head = $sprites/palm.global_position
	var tail = $sprites.global_position
	var pointing_towards = head - tail
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1
