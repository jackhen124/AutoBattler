extends "res://Units/Unit.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_attack = 4
	_hp = 5
	_tribe = _tribes.water
	_clas = _clases.warrior
	_tier = 3
	_id = 3
	_battleStart = false
	pass # Replace with function body.

func setDesc():
	_desc = str("The ally to my left has Multistrike: +",pow(2,_level-1))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
