extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var unitLibrary1
var unitLibrary2
var unitLibrary3
var unitLibrary4
var unitLibrary5
var unitInfo

var unit
var maxLevel

var nextExpGoal
var baseIncome
var stage
var playerHealth

var t1Prob
var t2Prob
var t3Prob
var t4Prob
var t5Prob
var t1Start
var t2Start
var t3Start
var t4Start
var t5Start
var allInc
var probSums
var bonusIncome
var allProbs
var isTest
# Called when the node enters the scene tree for the first time.
func _ready():
	gameInitialize(false)
	baseIncome = 5
	t1Prob = []
	t2Prob = []
	t3Prob = []
	t4Prob = []
	t5Prob = []
	allProbs = []
	t2Start = 1
	t3Start = 3
	t4Start = 5
	t5Start = 7
	allInc = 10
	maxLevel = 12
	setTierProbs()
	probSums = []
	for i in range(maxLevel):
		var cur = allProbs[0][i]+allProbs[1][i]+allProbs[2][i]+allProbs[3][i]+allProbs[4][i]
		probSums.append(cur)
	print(probSums)
	unit = preload("res://Units/Unit.tscn")
	unitLibrary1 = []
	unitLibrary2 = []
	unitLibrary3 = []
	unitLibrary4 = []
	unitLibrary5 = []
	
	
	unitLibrary1.append(load("res://Units/Unit1.tscn"))
	unitLibrary1.append(load("res://Units/Unit4.tscn"))
	unitLibrary1.append(load("res://Units/Unit5.tscn"))
	
	unitLibrary2.append(load("res://Units/Unit2.tscn"))
	unitLibrary2.append(load("res://Units/Unit6.tscn"))
	
	unitLibrary3.append(load("res://Units/Unit3.tscn"))
	#unitInfo = []
	#for i in range(unitLibrary.size()):
	#	unitInfo.append(storeUnit(unitLibrary[i]))
	
	#ownedSpots = []
	
	get_tree().change_scene("res://MainMenu.tscn")
	pass # Replace with function body.

func gameInitialize(isTest):
	pass
	
	
func storeUnit(scene):
	var s = scene.instance()
	add_child(s)
	#          0        1        2      3        4       5       6       7
	return([s._tier,s._attack,s._hp,s._tribe,s._clas,s._desc,s._name])
	
	
func setTierProbs():
	var t2Cur = 0
	var t3Cur = 0
	var t4Cur = 0
	var t5Cur = 0
	for i in range(maxLevel):
		t1Prob.append(100)
		if i >= t2Start:
			if(t2Cur < 100):
				t2Cur+=allInc
		t2Prob.append(t2Cur)
		if i >= t3Start:
			if(t3Cur < 100):
				t3Cur+=allInc
		t3Prob.append(t3Cur)
		if i >= t4Start:
			if(t4Cur < 100):
				t4Cur+=allInc
		t4Prob.append(t4Cur)
		if i >= t5Start:
			if(t5Cur < 100):
				t5Cur+=allInc
		t5Prob.append(t5Cur)
	allProbs.append(t1Prob)
	allProbs.append(t2Prob)
	
	#print(t2Prob)
	allProbs.append(t3Prob)
	#print(t3Prob)
	allProbs.append(t4Prob)
	#print(t4Prob)
	allProbs.append(t5Prob)
	#print(t5Prob)
	
# rt 1D array of length maxLevel

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
