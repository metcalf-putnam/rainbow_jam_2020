extends Area2D
class_name Memory
var player_hit = false
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


func _on_Memory_body_entered(body):
	if body.is_in_group("player"):
		player_hit = true
		EventHub.emit_signal("player_hit")
		destroy()


func set_velocity(vector_in):
	velocity = vector_in
	set_process(true)


func destroy():
	velocity = Vector2()
	$AnimationPlayer.play("destroy")
	if !player_hit:
		EventHub.emit_signal("memory_destroyed")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()


func _on_Timer_timeout():
	destroy()


func disintegrate():
	player_hit = true
	destroy()


func _process(delta):
	position += velocity * delta


func _on_Memory_area_entered(area):
	if area.is_in_group("attack"):
		disintegrate()
