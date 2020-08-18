extends KinematicBody2D
class_name SoloPart

var speed_multiplier = 1
var speed
var gravity = 500
var animationState : AnimationNodeStateMachinePlayback
var strength := 0.5
var particles = CPUParticles2D


func set_base_speed(base_speed):
	speed = base_speed * speed_multiplier


func set_particles():
	pass
	

func attack():
	set_physics_process(false)
	animationState.travel("attack")
	

func _on_attack_hit():
	EventHub.emit_signal("destruction", strength)


func _on_attack_end():
	set_physics_process(true)


func _ready():
	animationState = $AnimationTree["parameters/playback"]
	set_particles()


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
	pass
