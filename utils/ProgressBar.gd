extends ProgressBar
var half_health_reached := false
var quarter_health_reached := false


func _ready():
	value = Global.town_health
	EventHub.connect("health_changed", self, "modify")
	

func modify(change):
	value += change
	Global.town_health = value
	if value <= 1:
		EventHub.emit_signal("town_destroyed")
		
	elif value <= 50 and !half_health_reached:
		EventHub.emit_signal("town_halved")
		half_health_reached = true
	elif value <= 25 and !quarter_health_reached:
		EventHub.emit_signal("town_quartered")
		quarter_health_reached = true


