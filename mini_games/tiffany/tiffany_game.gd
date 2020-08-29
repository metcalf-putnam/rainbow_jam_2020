extends Node2D

export (PackedScene) var Memory
var scene_name = "tiffany"
var rng
var index := 0
var memories = ["“Tiffany has such an annoying voice. Ugh, just listen to that vocal fry”",
		"“Tiffany is never going to get ahead in life sounding like that.”",
		"Tiffany could hear them",
		"But Tiffany was weak",
		"She closed her mouth, vowing to be the good little girl",
		"But [i]they[/i] helped her find her voice",
		"And now she’s never shutting up again"]


func _ready():
	EventHub.emit_signal("memory_scene")
	EventHub.emit_signal("new_title", scene_name)
	EventHub.connect("memory_destroyed", self, "_on_memory_destroyed")
	rng = RandomNumberGenerator.new()
	create_memory()


func _on_memory_destroyed():
	EventHub.emit_signal("thought_started", memories[index])
	index += 1
	if index >= memories.size():
		$Timer.stop()
		yield(get_tree().create_timer(5), "timeout")
		Transition.change_scene("res://stages/unknown_stage_3_1.tscn")


func _on_Timer_timeout():
	create_memory()


func create_memory():
	var memory = Memory.instance()
	add_child(memory)
	var index = rng.randi_range(0, $SpawnPositions.get_child_count() - 1)
	memory.position = $SpawnPositions.get_child(index).position
