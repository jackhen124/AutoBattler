extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

onready var game = get_tree().get_root().get_node("Game")
func _ready():
	
	pass # Replace with function body.

	
func _on_TextureButton_pressed():
	get_parent().onClick()
	
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_mouse_entered():
	
	game.info.displayUnitInfo(get_parent())
	pass # Replace with function body.


func _on_TextureButton_mouse_exited():
	game.info.unitInfo.hide()
	pass # Replace with function body.


func _on_TextureButton_button_down():
	get_parent().grabAttempted()
	pass # Replace with function body.


func _on_TextureButton_button_up():
	#get_parent().grabReleased()
	pass # Replace with function body.
