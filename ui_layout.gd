extends CanvasLayer
var state := "normal" 

func _ready():
	EventHub.connect("new_title", self, "change_title")
	EventHub.connect("memory_scene", self, "_on_memory_scene")
	EventHub.connect("normal_scene", self, "_on_normal_scene")


func change_title(new_title : String):
	$LocationLabel.text = new_title

func _on_memory_scene():
	if state == "memory":
		EventHub.emit_signal("ui_changed")
		$Music.play("memory")
		return
	$AnimationPlayer.play("to_memory")
	state = "memory"

func _on_normal_scene():
	if state == "normal":
		EventHub.emit_signal("ui_changed")
		$Music.play("normal")
		return
	$AnimationPlayer.play("to_normal")
	state = "normal"
	
func get_state():
	return state

func _on_AnimationPlayer_animation_finished(_anim_name):
	EventHub.emit_signal("ui_changed")
