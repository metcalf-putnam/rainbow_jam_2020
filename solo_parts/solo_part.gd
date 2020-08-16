extends KinematicBody2D


export var speed = 400
var gravity = 500
var was_going_left = true
var animationState : AnimationNodeStateMachinePlayback



func attack():
	set_physics_process(false)
	animationState.travel("attack")


func _on_attack_end():
	set_physics_process(true)


func _ready():
	animationState = $AnimationTree["parameters/playback"]


func _input(event):
	if event.is_action_pressed("ui_select"):
		attack()


func _physics_process(delta):
	var velocity = Vector2()	
	
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if velocity.length() > 0:
		animationState.travel("move")
		if (was_going_left and velocity.x > 0):
			scale.x = -1
			
		elif (not was_going_left and velocity.x < 0):
			scale.x = -1

	else:
		animationState.travel("idle")
	
	# Only move left/right if idle
	if animationState.get_current_node() == "move":
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2()
	
	velocity.y += gravity
	velocity = move_and_slide(velocity) 
	if velocity.x != 0:
		was_going_left = velocity.x < 0
