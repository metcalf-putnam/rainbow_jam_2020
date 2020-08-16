extends Node2D


var scene_path
onready var current_scene := $unknown


# Called when the node enters the scene tree for the first time.
func _ready():
	EventHub.connect("fade_finished", self, "_change_scene")
	EventHub.connect("city_triggered", self, "_on_city_triggered")
	current_scene.initialize_player($Player)
	

func _on_city_triggered():
	scene_path = "res://city.tscn"
	_start_fade_out()
	
	
func _on_unknown_triggered():
	scene_path = "res://unknown.tscn"
	_start_fade_out()
	
	
func _start_fade_out():
	Transition.fade_out()
	
	
func _change_scene():
	print("changing scene!")
	#current_scene.queue_free()
	current_scene = load(scene_path).instance()
	add_child(current_scene)
	move_child(current_scene, 0)
	current_scene.initialize_player($Player)
	Transition.fade_in()
	
