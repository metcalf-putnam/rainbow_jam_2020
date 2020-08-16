extends KinematicBody2D


export var speed = 400
var gravity = 500
var was_going_left = true


func _physics_process(delta):
	var velocity = Vector2()	
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if velocity.length() > 0:
		$AnimationPlayer.play("move")
		if (was_going_left and velocity.x > 0):
			scale.x = -1
			
		elif (not was_going_left and velocity.x < 0):
			scale.x = -1

	else:
		$AnimationPlayer.play("rest")
		
	velocity = velocity.normalized() * speed
	velocity.y += gravity
	velocity = move_and_slide(velocity) 
	if velocity.x != 0:
		was_going_left = velocity.x < 0
