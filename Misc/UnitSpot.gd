extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var full
var unit
enum spotTypes{
	bench,lineup,ally,enemy
}
var type

# Called when the node enters the scene tree for the first time.
func _ready():
	unit = null
	full = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
