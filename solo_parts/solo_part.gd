extends KinematicBody2D


export var speed = 400
var gravity = 500
var animationState : AnimationNodeStateMachinePlayback



func attack():
	set_physics_process(false)
	animationState.travel("attack")


func _on_attack_hit():
	$sprites/bicep/forearm/end/CPUParticles2D.emitting = true


func _on_attack_end():
	$sprites/bicep/forearm/end/CPUParticles2D.emitting = false
	set_physics_process(true)


func _ready():
	animationState = $AnimationTree["parameters/playback"]


func _input(event):
	if event.is_action_pressed("ui_select"):
		attack()


func _physics_process(_delta):
	var velocity = Vector2()	
	
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if velocity.length() > 0:
		animationState.travel("move")
		turn_towards(velocity.x)

	else:
		animationState.travel("idle")
	
	# Only move left/right if idle
	if animationState.get_current_node() == "move":
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2()
	
	velocity.y += gravity
	velocity = move_and_slide(velocity) 
	

func turn_towards(x_direction : float):
	var head = $sprites/bicep/forearm/end.global_position
	var tail = $sprites/bicep.global_position
	var pointing_towards = head - tail
	
	if x_direction < 0 and pointing_towards.x < 0 or x_direction > 0 and pointing_towards.x > 0:
		return
		
	scale.x = -1
