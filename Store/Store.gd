extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tierProb
var rng
var rerollCost

onready var playingBoard = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():

	rerollCost = 2
	playingBoard = get_parent()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	populateStore(false)
	
	get_node("LevelupCoinLabel").get_node("Label").text = str(get_parent().levelupCost)
	get_node("RerollCoinLabel").get_node("Label").text = str(rerollCost)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func populateStore(isReroll):
	
	
	if isReroll:
		for i in range(5):
			if get_node(str("Selection/b",i)).get_children().size() > 0:
				get_node(str("Selection/b",i)).get_children()[0].queue_free()
	for i in range(4):
		
		var t
		
		var li = get_parent().level - 1
		var rand = rng.randi_range(0, Global.probSums[li])
		var choice
		if rand <= 100:
			t = 1
			choice = Global.unitLibrary1[rng.randi_range(0,Global.unitLibrary1.size()-1)].instance()
		elif rand <= Global.allProbs[0][li]+Global.allProbs[1][li]:
			t=2
			choice = Global.unitLibrary2[rng.randi_range(0,Global.unitLibrary2.size()-1)].instance()
		elif rand <= Global.allProbs[0][li]+Global.allProbs[1][li]+Global.allProbs[2][li]:
			t=3
			choice = Global.unitLibrary3[rng.randi_range(0,Global.unitLibrary3.size()-1)].instance()
		elif rand <= Global.allProbs[0][li]+Global.allProbs[1][li]+Global.allProbs[2][li]+Global.allProbs[3][li]:
			t=4
			choice = Global.unitLibrary4[rng.randi_range(0,Global.unitLibrary4.size()-1)].instance()
		elif rand <= Global.allProbs[0][li]+Global.allProbs[1][li]+Global.allProbs[2][li]+Global.allProbs[3][li]+Global.allProbs[4][li]:
			t=5
			choice = Global.unitLibrary5[rng.randi_range(0,Global.unitLibrary5.size()-1)].instance()
		
		get_node(str("Selection/b",i)).add_child(choice) 
		


func _on_BuyExpButton_pressed():
	if get_parent().coins >= playingBoard.levelupCost:
		
		get_parent().levelup()
		get_parent().coins-= playingBoard.levelupCost
		get_node("LevelupCoinLabel").get_node("Label").text = str(get_parent().levelupCost)
	pass # Replace with function body.


func _on_RerollButton_pressed():
	if get_parent().coins >= rerollCost:
		get_parent().coins -= rerollCost
		populateStore(true)
		
	pass # Replace with function body.


func _on_NextRoundButton_pressed():
	playingBoard.add_child(load("res://Battlefield.tscn").instance())
	queue_free()
	pass # Replace with function body.
