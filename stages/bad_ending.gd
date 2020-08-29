extends Node2D
var text_speed := 10 # characters per second
var index := 0
var end_chars

var epilogue = ["Once there was a monster that wanted to be stronger. She loved blood and battle and trusted no one but herself. ",
		"She destroyed anyone who threatened her, but her heart always held her back from going too far, whispering “you know this is wrong.”",
		"The monster knew she could never be truly strong with a weak heart like that, so she ripped the heart out with her own hand and locked it away, high up in a tower where it could never be found.",
		"However, without the heart’s guiding influence, the monster became overwhelmed by violence.",
		"She rampaged across the city until the people banded together to defeat her. They tore her into pieces and scattered her through the forest, to forget and to be forgotten…",
		"Until one day, the hand that had ripped her heart away started to remember..."]


func _ready():
	Global.cora_met_in_present_form = false
	EventHub.emit_signal("new_title", "false ending")
	$RichTextLabel.text = epilogue[index]
	end_chars = epilogue[index].length()
	animate_text()


func advance():
	index += 1
	if index >= epilogue.size():
		Transition.change_scene("res://stages/unknown_stage_1.tscn")
	else:
		$RichTextLabel.visible_characters = 0
		$RichTextLabel.text = epilogue[index]
		animate_text()


func animate_text():
	var duration = end_chars / text_speed
	print("duration: ", duration)
	var tween = get_node("Tween")
	tween.interpolate_property($RichTextLabel, "percent_visible", 
			0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	
func _input(event):
	var mouse_click = event is InputEventMouseButton and event.pressed
	var button_click = event is InputEventKey and event.is_action_pressed("ui_accept")
	if !(mouse_click or button_click):
		return
		
	if $Tween.is_active():
		print("tween active")
		$Tween.stop_all()
		$RichTextLabel.percent_visible = 1	
	else:
		advance()
