extends "res://Units/Unit.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_hp = 4
	_attack = 1
	_tribe = _tribes.wind
	_clas = _clases.guardian
	_tier = 1
	_id = 4
	_battleStart = true
	pass # Replace with function body.


func setDesc():
	#print("setting desc in child")
	_desc = str("BattleStart: Gain +",pow(2,_level-1),"/+0 for each other wind ally")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func battleStart():
	
	var a = 0
	var h = 0
	for spot in _spot.get_parent().get_children():
		if spot.unit._tribe == spot.unit._tribes.wind && spot != _spot:
			a+=pow(2,_level-1)
			
	buffSelf(a,h)

