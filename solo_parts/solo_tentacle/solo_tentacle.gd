extends SoloPart


func _ready():
	speed_multiplier = 1
	jump_multiplier = .1
	._ready()


func turn_towards(x_direction : float):
	var head = $sprites/base/sec/third/r_fourth/r_fifth/r_tip/end.global_position
	var tail = $sprites.global_position
	var pointing_towards = head - tail
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1
