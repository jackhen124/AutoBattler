extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum gameState {
	buying
	fighting
}
var state
var storeScene = load("res://Store/smallerStore.tscn")
onready var bench = get_node("Bench")



onready var lineUpPoint = get_node("LineupPoint")
var lineupSpot = load("res://Misc/LineupSpot.tscn")
var lineup = []

var income
var sep

var coins = 5
var level = 1
var health
var levelupCost

var baseIncome
var bonusIncome
var ownedUnits
var ownedSpots
var unitInfo
var basicInfo
var infoPanel
var levelupCosts
# Called when the node enters the scene tree for the first time.
func _ready():
	
	levelupCosts = [5,10,15,20,25,30,35,40,45,50]
	levelupCost = levelupCosts[0]
	var level
	var coins
	var curExp
	
	bonusIncome = 0
	
	
	sep = 80
	
	
	
	health = 20
	
	ownedUnits = []
	ownedSpots = []
	for i in range(10):
		ownedSpots.append(get_node(str("p",i)))
	addSpotToLineup()
	showStore()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("CoinLabel").get_node("Label").text = str(coins)
	#bonusIncome = floor(Global.coins / 10)
	#if bonusIncome > 5:
		#bonusIncome = 5
	
	
	get_node("ExpPoints").text = "Level: " + str(level)
	get_node("Income").text = "Income: " + str(Global.baseIncome," + ", floor(coins/10))
	get_node("HeartLabel/Label").text = str(health)
	
	pass

func showStore():
	state = gameState.buying
	var newStore = storeScene.instance()
	add_child(newStore)

func levelup():
	level+=1
	levelupCost = levelupCosts[level - 2]
	
	addSpotToLineup()
	
func addSpotToLineup():
	var newSpot = lineupSpot.instance()
	add_child(newSpot)
	newSpot.position = lineUpPoint.position
	if lineup.size() <1:
		newSpot.position = lineUpPoint.position
	else:
		newSpot.position.x = lineup[lineup.size()-1].position.x + sep
	lineup.append(newSpot)
	
	if lineup.size()!=1:
		for i in range(lineup.size()):
			lineup[i].position.x -= sep/2
			
	ownedSpots.append(newSpot)
	
func showTip(tip):
	get_node("Tip").text = tip
	

func newStage():
	if levelupCost > 0:
		levelupCost -= 1
	get_parent().showStore()
	coins += Global.baseIncome + floor(coins / 10)
	
	


	
