extends Node2D


export var speed = 175
export var jump_speed = 475
export var gravity = 980
var main_piece 
export (PackedScene) var Hand
export (PackedScene) var HandTentacle
export (PackedScene) var Medusa 


func _ready():
	main_piece = Global.get_main_piece()
	if !main_piece:
		main_piece = Medusa
	add_piece(main_piece)
	new_main_piece(main_piece)


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
	Global.cora_met_in_present_form = false
