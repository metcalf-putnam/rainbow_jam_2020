extends Node2D
class_name City
var healing := 20
var scene_name := "city"


func _on_scene_change_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://unknown.tscn")		


func _ready():
	$Camera2D.current = true
	EventHub.connect("destruction", self, "_on_destruction")
	EventHub.emit_signal("new_title", scene_name)
	

func _on_destruction(damage):
	EventHub.emit_signal("health_changed", -damage)


func _on_Timer_timeout():
	EventHub.emit_signal("health_changed", healing)
	# TODO: add sounds

