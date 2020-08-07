extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var amount
var firstFrame
var speed
var timer
var time
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 0
	time =50
	speed = .75
	firstFrame = true
	get_node("Label").text = ""
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firstFrame:
		firstFrame = false
		if amount > 0:
			get_node("Label").text += "+"
		elif amount < 0:
			get_node("Label").text += "-"
		
		get_node("Label").text +=str(amount)
	position.y += speed
	timer+=1
	if timer >= time:
		queue_free()
	pass
