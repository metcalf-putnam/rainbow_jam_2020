extends Node2D
class_name City
var healing := 20
var scene_name := "city"
var camera_normal = Vector2(515, 309)
var prog_normal = Vector2(455, 115)
var offset = 250


func _on_scene_change_trigger_body_entered(body):
	if body.is_in_group("player"):
		Transition.change_scene("res://unknown.tscn")


func _ready():
	$Camera2D.current = true
	$Camera2D.position = camera_normal
	EventHub.connect("destruction", self, "_on_destruction")
	EventHub.emit_signal("new_title", scene_name)
	EventHub.connect("town_destroyed", self, "_on_town_destroyed")
	EventHub.emit_signal("normal_scene")
	

func _on_destruction(damage):
	EventHub.emit_signal("health_changed", -damage)


func _on_Timer_timeout():
	EventHub.emit_signal("health_changed", healing)
	# TODO: add sounds


func _on_CameraChangeTrigger_body_entered(body):
	if body.is_in_group("player"):
		$Camera2D.position.y = camera_normal.y - offset
		var end_pos = Vector2(prog_normal.x, prog_normal.y - offset)
		$Tween.interpolate_property($ProgressBar, "rect_position", $ProgressBar.rect_position, end_pos, .2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()


func _on_CameraChangeTrigger_body_exited(body):
	if body.is_in_group("player"):
		$Camera2D.position = camera_normal
		$Tween.interpolate_property($ProgressBar, "rect_position", $ProgressBar.rect_position, prog_normal, .2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()


func _on_town_destroyed():
	pass
