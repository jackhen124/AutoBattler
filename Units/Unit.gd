extends Node2D
class_name UnitClass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _tier
var _name 
var _id
var _attack
var _hp
var _battleStart
enum _tribes {
	fire,water,earth,wind,dark,heartless
}
var _tribe
enum _clases {
	warrior,mage,hunter,guardian,shaman,summoner,none
}
var _clas
var _desc
enum _states {
	store,bench,lineup,grabbed,battle,dead,absorb,battleStart,attacking,actionPause,dead
}
enum _attackStates{
	movingTo,onAttack,hitting,returning
}
var _attackState
var _state
#func _init(level):
#	_attack = _attack*level
#	_hp = _hp*level
var firstUpdate = true
var curAttack
var curHealth

var _spot
var _level
var _levelDiffs
var _grabbedSpeed
var _absorbedBy
var _absorbSpeed

var _battleStartY
var _battleStartDone

var _battleSpeed
var _attackSpeed
var _hitSpeed
var rng
var _attackTarget
var _prevState
var _onAttack
var _battleStartReturning
var actionPauseTimer
var _onKill

var playingBoard
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	
	setup()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	_attackSpeed = 5.5
	_hitSpeed = 8
	_battleStartReturning = false
	_battleSpeed = 4
	_absorbedBy = null
	_grabbedSpeed = 25.0
	_absorbSpeed = 20.0
	_levelDiffs = [1,2,4]
	_level = 1
	_state = _states.store
	_battleStart = false
	_onAttack = false
	_onKill = false
	z_as_relative = true
	z_index = 2
	pass # Replace with function body.

func _process(delta):
	updateOverlay()
	
	if(firstUpdate):
		updateOverlay()
		updateLabels()
		if _state == _states.store:
			get_node("UnitOverlay").get_node("CoinLabel").get_node("Label").text = str(_tier +1)
		else: 
			get_node("UnitOverlay").get_node("CoinLabel").queue_free()
		
		firstUpdate = false
		
	
	if _state == _states.dead:
		
		pass
	if _state == _states.actionPause:
		actionPauseTimer-=1
		if actionPauseTimer <=0:
			_state = _prevState
		pass
	if _state == _states.attacking:
		
		if _attackState == _attackStates.movingTo:
			var targetOffset = 85
			var movingToPos = _attackTarget.get_global_position()
			if _spot.get_parent().isAllies:
				movingToPos.y += targetOffset
			else:
				movingToPos.y -= targetOffset
			if globalMoveToward(movingToPos,_attackSpeed):
				_attackState = _attackStates.onAttack
			
		if _attackState == _attackStates.onAttack:
			actionPause(30)
			onAttack()
			_attackState = _attackStates.hitting
		if _attackState == _attackStates.hitting:
			if globalMoveToward(_attackTarget.get_global_position(), _hitSpeed):
				combat(_attackTarget)
				_attackState = _attackStates.returning
		if _attackState == _attackStates.returning:
			if globalMoveToward(_spot.get_global_position(), _attackSpeed):
				_state = _states.battle
				
				playingBoard.get_node("Battlefield").increaseIndex(true)
	if _state == _states.battle:
		position = position.move_toward(_spot.get_global_position(),_battleSpeed)
	if _state == _states.battleStart:
		var offset = 50
		var bsSpeed = 3
		if _spot.get_parent().isAllies:
			_battleStartY = _spot.get_global_position().y - offset
		else:
			_battleStartY = _spot.get_global_position().y + offset
		if get_global_position().y != _battleStartY && !_battleStartReturning:
			set_global_position(get_global_position().move_toward(Vector2(get_global_position().x,_battleStartY),bsSpeed))
			#position = position.move_toward(Vector2(position.x,_battleStartY),bsSpeed)
			#actionPause(10)
		elif get_global_position().y == _battleStartY && !_battleStartReturning:
			actionPause(20)
			_battleStartReturning = true
			battleStart()
			actionIndicator()
		elif _battleStartReturning:
			if globalMoveToward(_spot.get_global_position(),_battleSpeed):
				playingBoard.get_node("Battlefield").increaseIndex(true)
				_state = _states.battle
		
				
		#scale = Vector2(1,1)
	if _state == _states.absorb:
		position = position.move_toward(_absorbedBy.position, _absorbSpeed)
		if position.distance_to(_absorbedBy.position) < 2:
			_spot.unit = null
			queue_free()
	
	if _state == _states.grabbed:
		z_index = 3
		currentlyGrabbed()
	if(_state == _states.bench || _state == _states.lineup):
		z_index = 2
		if position != _spot.position:
			
			position = position.move_toward(_spot.position, _grabbedSpeed)
			#moveTowards(_spot.position.x,_spot.position.y,_grabbedSpeed)
		pass
	
	pass
	
func setup():
	
	playingBoard = get_parent()
	while !playingBoard.is_in_group("playingBoard"):
		playingBoard = playingBoard.get_parent()
	player = get_tree().get_root().get_node("Game").get_node("Player")
	
func actionPause(time):
	_prevState = _state
	_state = _states.actionPause
	actionPauseTimer = time
	
	
func globalMoveToward(pos,speed):
	set_global_position(get_global_position().move_toward(pos,speed))
	return get_global_position() == pos 
	
func updateOverlay():
	
	#print(str(_attack))
	get_node("UnitOverlay").get_node("StatBar").get_node("Attack").text = str(_attack)
	get_node("UnitOverlay").get_node("StatBar").get_node("Health").text = str(_hp)
	
	setDesc()
	
func updateLabels():
	var t = ""
	var tc
	var brown = Color( 0.65, 0.16, 0.16, 1 )
	var sandybrown = Color( 0.96, 0.64, 0.38, 1 )
	var burlywood = Color( 0.87, 0.72, 0.53, 1 )
	var mintcream = Color( 0.96, 1, 0.98, 1 )
	var mediumblue = Color( 0, 0, 0.8, 1 )
	var orangered = Color( 1, 0.27, 0, 1 )
	var darkslategray = Color( 0.18, 0.31, 0.31, 1 )
	var dimgray = Color( 0.41, 0.41, 0.41, 1 )
	if _tribe == _tribes.earth:
		t = "Earth"
		tc = brown
	if _tribe == _tribes.wind:
		t = "Wind"
		tc = mintcream
	if _tribe == _tribes.water:
		t = "Water"
		tc = mediumblue
	if _tribe == _tribes.fire:
		t = "Fire"
		tc = orangered
	if _tribe == _tribes.dark:
		t = "Dark"
		tc = darkslategray
	if _tribe == _tribes.heartless:
		t = "Heartless"
		tc = dimgray
	get_node("UnitOverlay").get_node("TribeLabel").text = t
	get_node("UnitOverlay").get_node("TribeLabel").set("custom_colors/font_color", tc)
	var c = ""
	if _clas == _clases.mage:
		c = "Mage"
	if _clas == _clases.shaman:
		c = "Shaman"
	if _clas == _clases.warrior:
		c = "Warrior"
	if _clas == _clases.guardian:
		c = "Guardian"
	if _clas == _clases.hunter:
		c = "Hunter"
	if _clas == _clases.summoner:
		c = "Summoner"
	
	get_node("UnitOverlay").get_node("ClasLabel").text = c
	
func setDesc():
	#print("setting desc in parent")
	pass

func onClick():
	if _state == _states.store:
		
		buy()
	elif _state == _states.bench || _state == _states.lineup:
		_state = _states.grabbed
		
func currentlyGrabbed():
	var mouseX = get_viewport().get_mouse_position().x
	var mouseY = get_viewport().get_mouse_position().y
	position = position.move_toward(Vector2(mouseX,mouseY), _grabbedSpeed)
	if Input.is_action_just_released("leftMouse"):
		onGrabReleased()
	
func buy():
	var noBenchSpace = true
	var cost = _tier
	if playingBoard.coins >= cost:
		for i in range(9):
			if playingBoard.ownedSpots[i].unit == null:
				#playingBoard.ownedUnits[i] = self
				noBenchSpace = false
				var target = playingBoard
				get_parent().remove_child(self)
				target.add_child(self)
				get_node("UnitOverlay").get_node("CoinLabel").queue_free()
				#set_owner(target)
				playingBoard.coins -= cost
				addToOwned(i)
				attemptUpgrade()
				_state = _states.bench
				
				break
	elif playingBoard.coins >= cost && noBenchSpace:
		playingBoard.showTip("There is no empty space on your bench")
	elif playingBoard.coins <= cost:
		playingBoard.showTip("Not Enough Coins")
	
		

func grabAttempted():
	if _state == _states.bench || _state == _states.lineup:
		_state = _states.grabbed

#func grabReleased():
func onGrabReleased():
	
	if _state == _states.grabbed:
		var closestEmpty = _spot
		for i in range(playingBoard.ownedSpots.size()):
			if playingBoard.ownedSpots[i].unit == null:
					if abs(position.distance_to(playingBoard.ownedSpots[i].position)) < abs(position.distance_to(closestEmpty.position)):
						closestEmpty = playingBoard.ownedSpots[i]
						
		switchSpots(closestEmpty)


func addToOwned(index):
	position = playingBoard.ownedSpots[index].position
	playingBoard.ownedSpots[index].unit = self
	_spot = playingBoard.ownedSpots[index]
	#_state = _states.bench
	
func switchSpots(newSpot):
	#print(str("switching spots to ",newSpot.name))
	if newSpot.unit == null:
		_spot.unit = null
		_spot = newSpot
		newSpot.unit = self
	if _spot.type == _spot.spotTypes.bench:
		_state = _states.bench
	elif _spot.type == _spot.spotTypes.lineup:
		_state = _states.lineup
	
func attemptUpgrade():
	var numDup = 0
	
	for i in range(playingBoard.ownedSpots.size()):
		if playingBoard.ownedSpots[i].unit != null:
			if playingBoard.ownedSpots[i].unit._id == _id && playingBoard.ownedSpots[i].unit._level == _level:
				numDup+=1
				if numDup == 3:
					upgradeSelf()
					break
			
func upgradeSelf():
	for i in range(playingBoard.ownedSpots.size()):
		if playingBoard.ownedSpots[i].unit != null:
			if playingBoard.ownedSpots[i].unit._id == _id:
				if playingBoard.ownedSpots[i].unit._level == _level && playingBoard.ownedSpots[i].unit != self:
					playingBoard.ownedSpots[i].unit.getAbsorbed(self)
	_level+=1
	_attack*=2
	_hp*=2
	get_node("Sprite").scale *= 1.25
	actionIndicator()
	updateOverlay()
	if _level < 3:
		attemptUpgrade()

func getAbsorbed(unit):
	_absorbedBy = unit
	_state = _states.absorb
	
func buffSelf(attack,hp):
	var indA = load("res://BattleElements/BuffIndicator.tscn").instance()
	var indH = load("res://BattleElements/BuffIndicator.tscn").instance()
	var statBar = get_node("UnitOverlay").get_node("StatBar")
	if attack != 0:
		_attack += attack
		statBar.get_node("aPos").add_child(indA)
		indA.amount = attack
		
		
	if hp != 0:
		_hp += hp
		statBar.get_node("hPos").add_child(indH)
		indH.amount = hp
		

func allBattleStart():
	#print(str(_battleStart))
	if _battleStart:
		
		_state = _states.battleStart
		
	else:
		#print(str("all battle strat:", _spot.type))
		get_parent().increaseIndex(false)
		
		
	
func battleStart():
	
	pass

func buffAdjacent(a,h):
	
	for i in _spot.get_parent().get_children().size():
		var pos = _spot.get_position_in_parent()
		#print(str("position in parent:", pos))
		if i == pos - 1 || i == pos + 1:
			if _spot.get_parent().get_child(i)!= null:
				_spot.get_parent().get_child(i).unit.buffSelf(a,h)
			
			
func buffAllAllies(a,h,buffSelf):
	for i in range(_spot.get_parent().get_child_count()):
		
		var pos = _spot.get_position_in_parent()
		#print(str("position in parent:", pos))
		if buffSelf:
			_spot.get_parent().get_child(i).unit.buffSelf(a,h)
		elif _spot.get_parent().get_child(i).unit != self:
			_spot.get_parent().get_child(i).unit.buffSelf(a,h)
			

	
func actionIndicator():
	
	var ind = load("res://Misc/ActionIndicator.tscn").instance()
	add_child(ind)
	ind.position.y-=20
	
func allAttack(targetSide):
	if targetSide.get_children().size()== 0:
		print("attacking side with no targets")
		pass
	_state = _states.attacking
	_attackState = _attackStates.movingTo
	
	var rand = rng.randi_range(1, targetSide.get_children().size())
	#print(str("rand: ",rand))
	while !is_instance_valid(targetSide.get_child(rand-1)):
		rand = rng.randi_range(1, targetSide.get_children().size())
		#print(str("selected new random target: ",rand))
	#print(str("selected target at rand: ", rand))
	
	_attackTarget = targetSide.get_child(rand-1).unit
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func onAttack():
	pass
	
func onKill():
	pass

func combat(target):
	#print("combat")
	takeDamage(target._attack)
	if !is_instance_valid(target):
		onKill()
	target.takeDamage(_attack)
	if _hp <= 0:
		get_parent().increaseIndex(true)
		
	
func takeDamage(damage):
	_hp -= damage
	#buffSelf(0,-damage)
	var ind = load("res://Misc/DamageIndicator.tscn").instance()
	add_child(ind)
	ind.t = damage
	ind.position.y-=25
	if _hp <= 0:
		var ghost = load("res://Misc/DeathIndicator.tscn").instance()
		get_parent().add_child(ghost)
		
		#_spot.get_parent().remove_child(_spot)
		
		ghost.set_global_position(get_global_position())
		get_parent().pause(30)
		_spot.queue_free()
		queue_free()
		_state = _states.dead
	pass
	
func randomTarget():
	var targetSide
	if _spot.get_parent().isAllies:
		targetSide = get_parent().enemies
	else:
		targetSide = get_parent().allies
	var rand = rng.randi_range(1, targetSide.get_children().size())
	
	while !is_instance_valid(targetSide.get_child(rand-1)):
		rand = rng.randi_range(1, targetSide.get_children().size())
		
	return targetSide.get_child(rand-1).unit
	
