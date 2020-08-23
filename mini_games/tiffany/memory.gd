extends Area2D
class_name Memory
var player_hit = false
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	$AnimationPlayer.play("idle")


func _on_Memory_body_entered(body):
	if body.is_in_group("player"):
		destroy()


func set_velocity(vector_in):
	velocity = vector_in
	set_process(true)


func destroy():
	velocity = Vector2()
	$AnimationPlayer.play("destroy")
	EventHub.emit_signal("memory_destroyed")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name != "idle":
		queue_free()


func _on_Timer_timeout():
	disappear()


func disappear():
	$AnimationPlayer.play("disappear")


func disintegrate():
	destroy()


func _process(delta):
	position += velocity * delta


func _on_Memory_area_entered(area):
	if area.is_in_group("attack"):
		disintegrate()
