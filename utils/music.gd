extends Node
var current 
var last
var min_vol = -40
var max_vol = 0
var duration := 3



func _on_bad_ending():
	$Tween.interpolate_property(current, "volume_db", max_vol, min_vol, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	last = current


func _on_good_ending():
	play("happy")


func _ready():
	EventHub.connect("bad_ending", self, "_on_bad_ending")
	EventHub.connect("good_ending", self, "_on_good_ending")


func play(new_track_str):
	print("new track requested: ", new_track_str)
	var new_track 
	match new_track_str:
		"memory":
			new_track = $Memory
			print("new track is memory")
		"normal": 
			new_track = $Normal
		"happy":
			new_track = $HappyEnding
	if new_track == current:
		print("same track!")
		return
	last = current
	new_track.volume_db = min_vol
	new_track.play()
	if current:
		$Tween.interpolate_property(current, "volume_db", max_vol, min_vol, duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_property(new_track, "volume_db", min_vol, max_vol, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	current = new_track


func _on_Tween_tween_all_completed():
	if last and last != current:
		last.stop()
