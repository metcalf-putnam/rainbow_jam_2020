extends Node

var cora_met_in_present_form := false


# City / Town global stats
var town_health = 100

# Player stats
var main_piece setget set_main_piece, get_main_piece
var pieces = []


func _ready():
	get_main_piece()


func set_main_piece(piece):
	main_piece = piece


func get_main_piece():
	return main_piece
	
