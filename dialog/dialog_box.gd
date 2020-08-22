extends Control

var dialog_node = null
const SPACER = ":    "
const t_PREFIX = "[center]"
const t_SUFFIX = "[/center]"
const dt_PREFIX = "[center][tornado radius = .5 freq = .5]"
const dt_SUFFIX = "[/tornado][/center]"
enum Mode {DIALOGUE, THOUGHT, DEEPTHOUGHT}
var mode = Mode.DIALOGUE
var t_text_speed := 10 # characters per second
var dt_text_speed := 7
var thought_wait_time = 3

signal cleared_text


func _ready():
	hide()
	_set_normal_theme()
	EventHub.connect("dialogue_started", self, "show_dialog")
	EventHub.connect("memory_scene", self, "_set_dark_theme")
	EventHub.connect("normal_scene", self, "_set_normal_theme")
	EventHub.connect("thought_started", self, "show_thought")
	EventHub.connect("deep_thought_started", self, "show_deep_thought")


func _set_dark_theme():
	$h/Text.modulate = Color(1, 1, 1)
	$h/Text.clear()


func _set_normal_theme():
	$h/Text.modulate = Color(0, 0, 0)
	$h/Text.clear()


func reset_text_label():
	$Tween.stop_all()
	$Timer.stop()
	$h/Text.percent_visible = 0
	$h/Text.clear()
	$h/Text.modulate.a = 1


func show_thought(thought : String):
	reset_text_label()
	mode = Mode.THOUGHT
	$h/Button.hide()

	$h/Text.bbcode_text = t_PREFIX + thought + t_SUFFIX
	animate_text(0, thought.length())
	show()


func show_deep_thought(thought : String):
	reset_text_label()
	mode = Mode.DEEPTHOUGHT
	$h/Button.hide()
	animate_text(0, thought.length())
	$h/Text.bbcode_text = dt_PREFIX + thought + dt_SUFFIX
	show()


func show_dialog(player, dialog):
	reset_text_label()
	mode = Mode.DIALOGUE
	show()
	$h/Button.show()
	$h/Button.grab_focus()
	dialog_node = dialog
	for c in dialog.get_signal_connection_list("dialog_finished"):
		if self == c.target:
			dialog_node.start_dialog()
			break
			return
	dialog_node.connect("dialog_started", player, "set_active", [false])
	dialog_node.connect("dialog_finished", player, "set_active", [true])
	dialog_node.connect("dialog_finished", self, "hide")
	dialog_node.connect("dialog_finished", self, "_on_dialog_finished", [player])
	dialog_node.start_dialog()
	_format_dialog()


func _on_dialog_finished(player):
	dialog_node.disconnect("dialog_started", player, "set_active")
	dialog_node.disconnect("dialog_finished", player, "set_active")
	dialog_node.disconnect("dialog_finished", self, "hide")
	dialog_node.disconnect("dialog_finished", self, "_on_dialog_finished")


func _on_Button_pressed():
	print("pressed!")
	if $Tween.is_active():
		$Tween.stop_all()
		$h/Text.percent_visible = 1
	else:
		dialog_node.next_dialog()
		_format_dialog()


func _format_dialog():
	var name_prefix = dialog_node.dialog_name.to_upper() + SPACER
	animate_text(len(name_prefix), len(name_prefix + dialog_node.dialog_text))
	$h/Text.bbcode_text = (t_PREFIX + name_prefix + dialog_node.dialog_text + t_SUFFIX)


func _on_Timer_timeout():
	var end_color = $h/Text.modulate
	end_color.a = 0
	$Tween.interpolate_property($h/Text, "modulate", $h/Text.modulate, end_color, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	hide()


func _input(event):
	if mode != Mode.DEEPTHOUGHT:
		return
		
	var mouse_click = event is InputEventMouseButton and event.pressed
	var button_click = event is InputEventKey and event.is_action_pressed("ui_accept")
	if !(mouse_click or button_click):
		return
		
	if $Tween.is_active():
		$Tween.stop_all()
		$h/Text.percent_visible = 1	
	else:
		_end_deep_thought()


func _end_deep_thought():
	var end_color = $h/Text.modulate
	end_color.a = 0
	$Tween.interpolate_property($h/Text, "modulate", $h/Text.modulate, end_color, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	EventHub.emit_signal("deep_thought_finished")
	EventHub.emit_signal("change_player_active_state", true)
	$Timer.stop()
	hide()
	mode = Mode.DIALOGUE


func animate_text(start_vis, end_vis):
	print("end_vis: ", end_vis)
	var speed = t_text_speed
	if mode == Mode.DEEPTHOUGHT:
		speed = dt_text_speed
		yield(get_tree().create_timer(.5), "timeout")
		print("end deepthought primer timer")
	var duration = (end_vis - start_vis) / speed
	print(duration)
	if mode == Mode.THOUGHT:
		$Timer.start(thought_wait_time + duration)
	var tween = get_node("Tween")
	tween.interpolate_property($h/Text, "visible_characters", 
			start_vis, end_vis, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	print("about to start tween")
	tween.start()
	print("started tween")
