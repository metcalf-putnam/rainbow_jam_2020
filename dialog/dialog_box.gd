extends Control

var dialog_node = null

func _ready():
	hide()


func show_dialog(player, dialog):
	show()
	$Button.grab_focus()
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
	$Name.bbcode_text = "[b]" + dialog_node.dialog_name + "[/b]"
	$Text.bbcode_text = dialog_node.dialog_text


func _on_Button_button_up():
	dialog_node.next_dialog()
	$Name.bbcode_text = "[b]" + dialog_node.dialog_name + "[/b]"
	$Text.bbcode_text = dialog_node.dialog_text


func _on_dialog_finished(player):
	dialog_node.disconnect("dialog_started", player, "set_active")
	dialog_node.disconnect("dialog_finished", player, "set_active")
	dialog_node.disconnect("dialog_finished", self, "hide")
	dialog_node.disconnect("dialog_finished", self, "_on_dialog_finished")
