extends Node

#var scene_mode = 


# City / Town global stats
var town_health = 100

# Player stats
var main_piece setget set_main_piece, get_main_piece
var pieces = []


func set_main_piece(piece):
	main_piece = piece


func get_main_piece():
	return main_piece
	

func get_pieces():
	return pieces

