extends Node2D


export var speed = 250
export var jump_speed = 500
export var gravity = 980
var main_piece 
var pieces = []
enum Parts {arm_l, arm_r, legs, torso, head}


func _ready():
	pieces = Global.get_pieces()
	main_piece = Global.get_main_piece()
	# TODO: have this actually all mean something vs. instancing the same arm no matter what
	
	if !main_piece:	
		add_piece(Parts.arm_r, 0)
		
	for piece in pieces:
		piece.set_base_speed(speed, jump_speed, gravity)
	
	
func add_piece(type, value):
	# TODO: do this a different way, with a dictionary living elsewhere
	# and only using ids to keep track of pieces, and looking up their qualities before loading
	
	var new_piece
	
	match type:
		Parts.arm_r:
			if value == 0:
				new_piece = preload("res://solo_parts/solo_arm/solo_arm.tscn").instance()
				new_piece.set_base_speed(speed, jump_speed, gravity)
	if new_piece:
		add_child(new_piece)
	if !main_piece:
		main_piece = new_piece
		#Global.set_main_pices


func set_camera_current():
	main_piece.set_camera_current(true)

