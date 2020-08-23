extends Node2D

export (PackedScene) var Memory
var scene_name = "tiffany"
var rng


func _ready():
	EventHub.emit_signal("memory_scene")
	EventHub.emit_signal("new_title", scene_name)
	EventHub.connect("memory_destroyed", self, "_on_memory_destroyed")
	EventHub.connect("deep_thought_finished", self, "_on_deep_thought_finished")
	rng = RandomNumberGenerator.new()
	create_memory()


func _on_memory_destroyed():
	EventHub.emit_signal("deep_thought_started", "a deep thought might go here")
	$Timer.stop()


func _on_deep_thought_finished():
	$Timer.start()


func _on_Timer_timeout():
	create_memory()


func create_memory():
	var memory = Memory.instance()
	add_child(memory)
	var index = rng.randi_range(0, $SpawnPositions.get_child_count() - 1)
	memory.position = $SpawnPositions.get_child(index).position
