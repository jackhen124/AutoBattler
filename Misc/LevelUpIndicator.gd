extends "res://Misc/ActionIndicator.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	sizeInc = .12
	maxScale = 4
	scale = scale * Vector2(.1,.1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale.x +=sizeInc
	scale.y +=sizeInc
	#get_node("Sprite").
	if scale.x >= maxScale:
		queue_free()
	pass
