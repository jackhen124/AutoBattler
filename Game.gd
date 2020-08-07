extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var stage
var players
var playerScene = load("res://Multiplayer/Player.tscn")
var botScene
var cams

onready var info = get_node("CanvasLayer").get_node("Gui").get_node("InfoPanel")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer").get_node("Gui").get_node("PlayerList").get_node("BattlerButton").battler = get_node("Player")
	stage = 1
	cams = []
	cams.append(get_node("Player").get_node("Cam"))
	
	addBots(3)
	pass # Replace with function body.


func addBots(num):
	for i in range(num):
		botScene = load("res://Multiplayer/Bot.tscn")
		var newBot = botScene.instance()
		
		add_child(newBot)
		
		newBot.position.x += (1200 * (i+1))
		cams.append(newBot.get_node("Cam"))
		
		newBot.myName = str("Bot-",i+1)
		newBot.get_node("PlayingBoard").showTip(newBot.myName)
		addPlayer(newBot)
		
	
func _unhandled_input(event):
	if Input.is_key_pressed(KEY_1):
		camTo(1)
	if Input.is_key_pressed(KEY_2):
		camTo(2)
	if Input.is_key_pressed(KEY_3):
		camTo(3)
	if Input.is_key_pressed(KEY_4):
		camTo(4)
	if Input.is_key_pressed(KEY_5):
		camTo(5)
	if Input.is_key_pressed(KEY_6):
		camTo(6)
	

func camTo(num):
	cams[num].make_current()
	
func addPlayer(p):
	var battlerButton = load("res://Multiplayer/BattlerButton.tscn").instance()
	get_node("CanvasLayer").get_node("Gui").get_node("PlayerList").add_child(battlerButton)
	battlerButton.text = p.myName
	battlerButton.battler = p
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
