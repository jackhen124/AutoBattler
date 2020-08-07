extends "res://Units/Unit.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_attack = 3
	_hp = 2
	_tribe = _tribes.water
	_clas = _clases.mage
	_tier = 1
	_id = 5
	_onAttack = true
	pass # Replace with function body.

func setDesc():
	#print("setting desc in child")
	_desc = str("Attack: Give a random enemy -3/-0 (", pow(2,_level-1), " time/s)")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func onAttack():
	for i in range(0, pow(2,_level-1)):
		var target = randomTarget()
		target.buffSelf(-3,0)
		if target._attack <0:
			target._attack = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
