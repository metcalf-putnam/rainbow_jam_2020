extends Area2D
var speed = Vector2(500, -5)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func set_direction(x_dir):
	if x_dir > 0:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
		speed.x *= -1


func _process(delta):
	position += speed * delta


func _on_OMG_body_entered(body):
	if body.is_in_group("hazard"):
		body.disintegrate()
