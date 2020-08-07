extends "res://Units/Unit.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_attack = 3
	_hp = 4
	_tribe = _tribes.water
	_clas = _clases.mage
	_tier = 2
	_id = 6
	
	pass # Replace with function body.

func setDesc():
	#print("setting desc in child")
	_desc = str("When I kill an enemy while attacking, give all allies +", pow(2,_level-1), "/+",pow(2,_level-1),".")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func onAttack():
	buffAllAllies(pow(2,_level-1),pow(2,_level-1),true)
	pass # Replace with function body.
