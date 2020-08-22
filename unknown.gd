extends Node2D
var scene_name := "crossroads"

func _ready():
	$Player.set_camera_current()
	

func _on_city_scene_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://city.tscn")


func _on_CrossroadsTrigger_body_entered(body):
	if body.is_in_group("player"):
		EventHub.emit_signal("new_title", scene_name)


func _on_mini_game_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://mini_games/tiffany/tiffany_game.tscn")
