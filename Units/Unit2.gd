extends "res://Units/Unit.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	_attack = 2
	_hp = 3
	_tribe = _tribes.fire
	_clas = _clases.shaman
	_tier = 2
	_id = 2
	_battleStart = true
	
	pass # Replace with function body.

func setDesc():
	_desc = str("BattleStart: give all other allies +",pow(2,_level-1),"/+0")
	
func battleStart():
	buffAllAllies(pow(2,_level-1),0,false)
	print("buffing allies")
	print(str(pow(2,_level-1)))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
