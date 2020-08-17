extends ProgressBar


func _ready():
	value = Global.town_health
	EventHub.connect("health_changed", self, "modify")

func modify(change):
	value += change
	Global.town_health = value
