extends KinematicBody2D
class_name SoloPart


signal grounded_updated

onready var platform_detector = $PlatformDetector
var speed_multiplier = 1
var jump_multiplier = 1
var speed = Vector2(150, 500)
var gravity = 980
var animationState : AnimationNodeStateMachinePlayback
var strength := 0.5
var particles = CPUParticles2D
var _velocity = Vector2()
var is_active = true
var is_grounded
const FLOOR_DETECT_DISTANCE = 20.0


func set_base_speed(base_speed, base_jump_speed, gravity_base):
	speed = Vector2(base_speed * speed_multiplier, base_jump_speed * jump_multiplier)
	gravity = gravity_base


func set_active(boolean):
	is_active = boolean


func set_particles():
	pass


func attack():
	if !is_active:
		return
	animationState.travel("attack")


func _on_attack_hit():
	EventHub.emit_signal("destruction", strength)


func _on_attack_end():
	pass


func set_camera_current(boolean):
	$CameraOffset/Camera2D.current = boolean


func _ready():
	$AnimationTree.active = true
	animationState = $AnimationTree["parameters/playback"]
	set_particles()
	EventHub.connect("change_player_active_state", self, "set_active")


func _input(event):
	if event.is_action_pressed("ui_select"):
		attack()
	if event.is_action_pressed("ui_up"):
		jump()


func jump():
	pass


func _physics_process(delta):
	var direction = get_direction()	
	var is_jump_interrupted = Input.is_action_just_released("ui_up") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, is_jump_interrupted)

	var need_to_turn = get_new_animation()
	if need_to_turn:
		turn_towards(direction.x)
	
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	var is_on_platform
	if platform_detector:
		is_on_platform = platform_detector.is_colliding()
	else:
		is_on_platform = false
	_velocity = move_and_slide_with_snap(
		_velocity, snap_vector, Vector2.UP, not is_on_platform, 4, 0.9, false
	)
	#_velocity = move_and_slide(_velocity, Vector2.UP) 
	_velocity.y += gravity * delta


func turn_towards(_x_direction : float):
	pass


func get_direction():
	if !is_active:
		return Vector2()
	var x_dir 

	x_dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		
	return Vector2(x_dir, -1 if is_on_floor() and Input.is_action_just_pressed("ui_up") else 0)


func get_new_animation():
	var animation_new = " "
	if Input.is_action_pressed("ui_accept") and is_active:
		animation_new = "attack"
	elif is_on_floor():
		animation_new = "move" if abs(_velocity.x) > 0.1 else "idle"
	else:
		animation_new = "falling" if _velocity.y > 0 else "jump"
	animationState.travel(animation_new)
	return animation_new == "move"


func calculate_move_velocity(
		linear_velocity,
		direction,
		is_jump_interrupted
	):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity
