extends Node2D

var scene_name = "frankie"
var index := 0
var thoughts := ["...move...", 
		"there was a time when that was all I thought about",
		'"smart spaghetti"', 
		"that's what a scientist called me", 
		"a scientist? My...creator?",
		'"what better thing to add to an all powerful creature?"', 
		"but I wasn't treated like smart spaghetti with [i]them[/i]",
		"[i]they[/i] gave me the space and support to find my true reach"]


func _ready():
	$solo_part.set_camera_current(true)
	EventHub.emit_signal("memory_scene")
	EventHub.emit_signal("new_title", scene_name)
	EventHub.connect("memory_destroyed", self, "_on_memory_destroyed")
	$solo_part.set_base_speed(150, 150, 980)
	get_tree().call_group("memory", "stop_timer")


func _on_memory_destroyed():
	EventHub.emit_signal("thought_started", thoughts[index])
	index += 1
	if index >= thoughts.size():
		yield(get_tree().create_timer(5.5), "timeout")
		Transition.change_scene("res://stages/unknown_stage_2_1.tscn")
