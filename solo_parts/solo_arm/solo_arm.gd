extends SoloPart


func set_particles():
	particles = $sprites/bicep/forearm/end/CPUParticles2D


func turn_towards(x_direction : float):
	var head = $sprites/bicep/forearm/end.global_position
	var tail = $sprites/bicep.global_position
	var pointing_towards = head - tail
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1
