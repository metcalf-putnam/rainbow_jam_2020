extends Node2D
var count = 0

export (PackedScene) var Memory
var scene_name = "tiffany"


func _ready():
	EventHub.emit_signal("new_title", scene_name)
	EventHub.connect("memory_destroyed", self, "_on_memory_destroyed")
	EventHub.connect("player_hit", self, "_on_player_hit")


func _on_memory_destroyed():
	count += 1
	update_count_label()


func _on_player_hit():
	count = 0
	update_count_label()


func update_count_label():
	$Count.text = str(count)


func _on_Timer_timeout():
	var memory = Memory.instance()
	add_child(memory)
	memory.position = $Spawn.position
	memory.set_velocity(Vector2(-250, 0))
