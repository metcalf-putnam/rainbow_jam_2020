extends SoloPart
class_name Arm


func _ready():
	._ready()
	EventHub.connect("start_hug", self, "hug")


func turn_towards(x_direction : float):
	var head = $sprites/palm.global_position
	var tail = $sprites.global_position
	var pointing_towards = head - tail
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1
	
func _on_hug_end():
	EventHub.emit_signal("hugged")
	
func hug():
	set_physics_process(false)
	animationState.travel("hug")
