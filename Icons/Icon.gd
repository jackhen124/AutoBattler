extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type
var firstFrame
var info
var sprite
var isUnit
var desc
var title
var desc2

var bonusInfo
var bonusInfo2
var parent
var player
onready var infoPanel = get_tree().get_root().get_node("Game").get_node("CanvasLayer").get_node("Gui").get_node("InfoPanel")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	#playingBoard = playingBoard.get_parent()
		
	#playingBoard = get_tree().get_root().get_node("PlayingBoard")
	
	#player = get_tree().get_root().get_node("Game").get_node("Player")
	
	#bonusInfo = player.get_node("Cam").get_node("InfoPanel").get_node("BonusInfo")
	
	#bonusInfo2 = player.get_node("Cam").get_node("InfoPanel").get_node("BonusInfo2")
	bonusInfo = infoPanel.get_node("BonusInfo")
	bonusInfo2 = infoPanel.get_node("BonusInfo2")
	firstFrame = true
	desc = "desc"
	title = "title"
	desc2 = ""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if firstFrame:
		firstFrame = false
		if get_parent().get_parent() is UnitClass:
			isUnit = true
			
			setSprite()
		else:
			isUnit = false
			setSprite()
	pass
func setSprite():
	pass
	
func showInfo():
	bonusInfo.get_node("Desc").text = desc
	bonusInfo.get_node("Title").text = title
	bonusInfo.get_node("Sprite").set_texture(get_normal_texture())
	bonusInfo.show()
	if desc2 != "":
		bonusInfo2.get_node("Desc").text = desc2
		bonusInfo2.show()
		
	pass


func _on_Icon_mouse_entered():
	
	showInfo()
	pass # Replace with function body.


func _on_Icon_mouse_exited():
	bonusInfo.hide()
	bonusInfo2.hide()
	pass # Replace with function body.
