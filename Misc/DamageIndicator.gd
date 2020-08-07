extends "res://Misc/ActionIndicator.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	time = 55
	timer = 0
	scale = Vector2(1.1,1.1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text = str(t)
	timer+=1
	#scale = scale + Vector2(.00,.01)
	if timer >= time:
		queue_free()
	get_node("Sprite").set_rotation_degrees(get_node("Sprite").get_rotation_degrees()+2.4)
	pass
