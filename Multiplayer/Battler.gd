extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var myName
var cam
var playingBoard
# Called when the node enters the scene tree for the first time.
func _ready():
	cam = get_node("Cam")
	playingBoard = get_node("PlayingBoard")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
