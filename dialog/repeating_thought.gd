extends Node

export var thought_1 : String
export var thought_2 : String
export var thought_3 : String
var thoughts = []
var index = -1

func _ready():
	if thought_1:
		thoughts.append(thought_1)
		index += 1
	if thought_2:
		thoughts.append(thought_2)
		index += 1
	if thought_3:
		thoughts.append(thought_3)
		index += 1

func _on_FirstDestructionConvo_repeating_thought():
	$Timer.start()

func _on_Timer_timeout():
	print("time out")
	if index >= 0:
		index = (index + 1) % thoughts.size()
		EventHub.emit_signal("thought_started", thoughts[index])
		print(thoughts[index])
