extends "res://Units/Unit.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_attack = 2
	_hp = 2
	_level = 1
	_tribe = _tribes.heartless
	_clas = _clases.none
	_tier = 1
	_battleStart = true
	pass # Replace with function body.

func setDesc():
	_desc = str("BattleStart: Gain +",pow(2,_level-1),"/+",2*pow(2,_level-1)," for each heartless ally.")
	
func battleStart():
	var a = 0
	var h = 0
	for spot in _spot.get_parent().get_children():
		if spot.unit._tribe == spot.unit._tribes.heartless && spot != _spot:
			#a+=pow(2,_level-1)
			h+=2*pow(2,_level-1)
	buffSelf(a,h)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
