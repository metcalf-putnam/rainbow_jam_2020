extends SoloPart

const OMG_VELOCITY = 500.0
const OMG = preload("omg.tscn")


func _ready():
	speed = Vector2(1, 550)
	EventHub.connect("player_hit", self, "_on_enemy_hit")


func turn_towards(x_direction : float):
	var pointing_towards = get_facing()
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1


func get_facing():
	var head = $sprites/Sprite/Mouth.global_position
	var tail = $sprites.global_position
	return head - tail


func jump():
	if !is_active:
		return
	animationState.travel("jump")
	var omg = OMG.instance()
	get_tree().get_root().add_child(omg)
	omg.global_position = global_position
	omg.set_downwards()

	
func attack():
	if !is_active:
		return
	animationState.travel("attack")
	var omg = OMG.instance()
	get_tree().get_root().add_child(omg)
	omg.global_position = $sprites/Sprite/Mouth.global_position
	var direction = get_facing().x
	omg.set_direction(direction)
	

func _on_enemy_hit():
	#set_physics_process(false)
	animationState.travel("hit")
	
func _on_recover():
	set_physics_process(true)
