extends Node2D


export var speed = 175
export var jump_speed = 475
export var gravity = 980
var main_piece 
var pieces = []
export (PackedScene) var Hand
export (PackedScene) var HandTentacle
export (PackedScene) var Medusa


func _ready():
	main_piece = Global.get_main_piece()
	# TODO: have this actually all mean something vs. instancing the same arm no matter what
	
	if !main_piece:	
		print("new main piece")
		main_piece = Hand
	add_piece(main_piece)


func add_piece(Type):
	var new_piece = Type.instance()
	new_piece.set_base_speed(speed, jump_speed, gravity)
	add_child(new_piece)


func set_camera_current():
	get_child(0).set_camera_current(true)
	

func new_main_piece(type):
	match type:
		"hand": 
			main_piece = Hand
		"hand_tentacle":
			main_piece = HandTentacle
		"medusa":
			main_piece = Medusa
	Global.set_main_piece(main_piece)
	get_child(0).queue_free()
	add_piece(main_piece)
