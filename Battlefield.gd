extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lineup
var initDone
var lineupSpot = load("res://Misc/LineupSpot.tscn")
onready var playingBoard = get_parent()
var enemySpots
var allySpots
var separationDistance = 80
onready var allies = get_node("Allies")
onready var enemies = get_node("Enemies")
var enemy1 = load("res://Enemies/Enemy1.tscn")
var actionReady
enum battleStates{
	prep, start, attack, end, pause
}
var battleState

var allyTurn
var prepTimer
var prepTime
var endTimer
var endTime
var pauseTimer = 0
var prevState
onready var game = get_tree().get_root().get_node("Game")
# Called when the node enters the scene tree for the first time.
func _ready():
	prepTime = 50
	prepTimer = 0
	allies.isAllies = true
	enemies.isAllies = false
	battleState = battleStates.prep
	z_index = 10
	allyTurn = true
	actionReady = true
	endTimer = 0
	endTime = 120
	#get_node("Allies").add_child(allySpots)
	
	for i in range(game.stage):
		print("creating enemy")
		var newSpot = lineupSpot.instance()
		var enemy = enemy1.instance()
		add_child(enemy)
		enemies.add_child(newSpot)
		newSpot.unit = enemy
		
		enemy._state = enemy._states.battle
		enemy.set_global_position(newSpot.get_global_position()) 
		enemy._spot = newSpot
		newSpot.type = newSpot.spotTypes.enemy
		
	
	for i in range(10,playingBoard.ownedSpots.size()):
		
		if playingBoard.ownedSpots[i].unit!=null:
			
			var curUnit = playingBoard.ownedSpots[i].unit
			var battlingUnit = load(curUnit.get_filename()).instance()
			
			add_child(battlingUnit)
			var newSpot = lineupSpot.instance()
			get_node("Allies").add_child(newSpot)
			newSpot.unit =battlingUnit
			battlingUnit._hp = curUnit._hp
			battlingUnit._attack = curUnit._attack
			battlingUnit._level = curUnit._level
			battlingUnit.get_node("Sprite").scale = curUnit.get_node("Sprite").scale
			battlingUnit.updateOverlay()
			battlingUnit._state = battlingUnit._states.battle
			battlingUnit.set_global_position(newSpot.get_global_position()) 
			battlingUnit._spot = newSpot
			newSpot.type = newSpot.spotTypes.ally
			battlingUnit.playingBoard = get_parent()
			
	
	#lineup = []
	#for i in range()
	#initDone = false
	arrangeNodes(enemies)
	arrangeNodes(allies)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pauseTimer > 0:
		pauseTimer-=1
		return
	if battleState == battleStates.prep:
		prepTimer+=1
		if prepTimer >= prepTime:
			battleState = battleStates.start
			print("battle prep over")
	else:
		if actionReady:
			if allyTurn:
				nextAction(allies)
				
			else:
				nextAction(enemies)
				
		pass
	
func pause(time):
	
	pauseTimer = time
	

func nextAction(side):
	actionReady = false

	
	
	if battleState == battleStates.start:
		if allies.done && enemies.done:
			actionReady = true
			battleState = battleStates.attack
			allies.actionIndex = 0
			enemies.actionIndex = 0
			allyTurn = true
		elif side.done:
			increaseIndex(true)
			return
		elif side.get_child(side.actionIndex) == null:
			side.done = true
			increaseIndex(true)
			return
		else:
			side.get_child(side.actionIndex).unit.allBattleStart()
		
	elif battleState == battleStates.attack:
		if allies.get_children().size() == 0:
			print("battle over LOSE")
			battleState = battleStates.end
			actionReady = true
			return
		if enemies.get_children().size()==0:
			print("Battle over WIN")
			battleState = battleStates.end
			actionReady = true
			return
		if !is_instance_valid(side.get_child(side.actionIndex)):
			increaseIndex(false)
			if side.actionIndex > side.get_child_count()-1:
				side.actionIndex = 0
				actionReady = true
				return
		elif battleState == battleStates.attack:
			
			if allyTurn:
				print("allies attacking")
				side.get_child(side.actionIndex).unit.allAttack(enemies)
			else:
				print("enemies attacking")
				side.get_child(side.actionIndex).unit.allAttack(allies)
	elif battleState == battleStates.end:
		actionReady = true
		endTimer+=1
		if endTimer >= endTime:
			game.stage+=1
			playingBoard.health-=enemies.get_child_count()
			playingBoard.newStage()
			queue_free()
		pass
		
func increaseIndex(actionCompleted):
	if allyTurn:
		allies.actionIndex +=1
	else:
		enemies.actionIndex+=1
	if actionCompleted:
		
		allyTurn = !allyTurn
	actionReady = true
	
func battleOver(enemiesLeft):
	Global.stage+=1
	
	#queue_free()
	
func arrangeNodes(n):
	var position_index = 0
	for c in n.get_children():
		c.position = Vector2(position_index * separationDistance, 0)
		
		c.unit.set_global_position(c.get_global_position())
		position_index+=1
	for c2 in n.get_children():
		c2.position.x -= (separationDistance/2)*position_index
		c2.unit.set_global_position(c2.get_global_position())
