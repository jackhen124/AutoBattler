
extends UnitClass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_attack = 2
	_hp = 3
	_tribe = _tribes.earth
	_clas = _clases.warrior
	_tier = 1
	_id = 1
	_battleStart = true
	pass # Replace with function body.

func setDesc():
	#print("setting desc in child")
	_desc = str("BattleStart: Give adjacent allies +0/+",pow(2,_level-1))
# Called every frame. 'delta' is the elapsed time since the previous frame.

func battleStart():
	buffAdjacent(0,pow(2,_level-1))
