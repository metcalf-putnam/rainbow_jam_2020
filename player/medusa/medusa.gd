extends SoloPart


# Called when the node enters the scene tree for the first time.
func _init():
	speed_multiplier = 3
	jump_multiplier = 1.5
	strength = 8
	
	
func swim(_boolean):
	pass


func turn_towards(x_direction : float):
	var head = $tentacle2/base/sec/third/RemoteTransform2D/RemoteTransform2D/RemoteTransform2D/Position2D.global_position
	var tail = $sprites.global_position
	var pointing_towards = head - tail
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1
