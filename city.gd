extends Node2D


func _on_scene_change_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://unknown.tscn")		


func _ready():
	$Camera2D.current = true
	EventHub.connect("destruction", self, "_on_destruction")
	

func _on_destruction(damage):
	EventHub.emit_signal("health_changed", damage)

