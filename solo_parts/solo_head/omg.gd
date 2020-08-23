extends Area2D
var speed = Vector2(500, -15)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func set_direction(x_dir):
	if x_dir > 0:
		$Sprite.flip_h = false
		$Sprite.flip_v = false
	else:
		$Sprite.flip_h = true
		$Sprite.flip_v = true
		speed.x *= -1

func set_downwards():
	speed = Vector2(0, 300)

func _process(delta):
	position += speed * delta


func _on_OMG_body_entered(body):
	if body.is_in_group("hazard"):
		body.disintegrate()
