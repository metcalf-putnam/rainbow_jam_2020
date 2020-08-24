extends Node2D

var scene_name = "frankie"


func _ready():
	$solo_part.set_camera_current(true)
	EventHub.emit_signal("memory_scene")
	EventHub.emit_signal("new_title", scene_name)
	EventHub.connect("memory_destroyed", self, "_on_memory_destroyed")
	$solo_part.set_base_speed(150, 150, 980)


func _on_memory_destroyed():
	EventHub.emit_signal("thought_started", "a thought will go here")
