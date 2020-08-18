extends Node

export(String, FILE, "*.json") var dialog_file
export(NodePath) var dialog_ui

var dialog_keys = []
var dialog_name = ""
var current = 0
var dialog_text = ""

signal dialog_started
signal dialog_finished

func start_dialog():
	emit_signal("dialog_started")
	current = 0
	index_dialog()
	dialog_text = dialog_keys[current].text
	dialog_name = dialog_keys[current].name


func next_dialog():
	current += 1
	print("size of dialog keys: ", dialog_keys.size())
	if current >= dialog_keys.size():
		emit_signal("dialog_finished")
		return
	dialog_text = dialog_keys[current].text
	dialog_name = dialog_keys[current].name


func index_dialog():
	var dialog = load_dialog(dialog_file)
	dialog_keys.clear()
	for key in dialog:
		dialog_keys.append(dialog[key])


func load_dialog(file_path):
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		var dialog = parse_json(file.get_as_text())
		return dialog


func _on_ConvoTrigger_body_entered(body):
	if body.is_in_group("player"):
		get_node(dialog_ui).show_dialog(body, self)
		EventHub.emit_signal("new_title", "dialog_test")
