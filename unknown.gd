extends Node2D


func _ready():
	$Player.set_camera_current()
	

func _on_city_scene_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://city.tscn")
