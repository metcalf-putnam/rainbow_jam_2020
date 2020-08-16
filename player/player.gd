extends Node2D


onready var main_piece = $solo_arm 


func set_camera_current():
	main_piece.get_node("Camera2D").current = true
