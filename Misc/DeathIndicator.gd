extends "res://Misc/ActionIndicator.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var switch
var switchTimer
var rand
# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 3
	timer = 0
	switch = true
	switchTimer = 0
	var rng= RandomNumberGenerator.new()
	rng.randomize()
	rand = rng.randf_range(-1,1)
	
	pass # Replace with function body.


 
func _process(delta):
	position.x+= .4*rand
	
	
	position.y -= 1
	timer +=1
	if timer >= 600:
		queue_free()
	pass
