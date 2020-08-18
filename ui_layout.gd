extends CanvasLayer

func _ready():
	EventHub.connect("new_title", self, "change_title")
	

func change_title(new_title : String):
	$LocationLabel.text = new_title
