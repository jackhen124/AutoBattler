extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.


func _on_TestButton_pressed():
	get_tree().change_scene("res://Game.tscn")
	Global.gameInitialize(true)
	pass # Replace with function body.
