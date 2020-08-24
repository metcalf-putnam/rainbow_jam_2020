extends SoloPart


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	$AnimationPlayer.play("jump")
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
