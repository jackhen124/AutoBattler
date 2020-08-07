extends "res://Icons/Icon.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func setSprite():
	if !isUnit:
		if name == "Warrior":
			isWarrior()
		elif name == "Mage":
			isMage()
		elif name == "Hunter":
			isHunter()
		elif name == "Guardian":
			isGuardian()
		elif name == "Shaman":
			isShaman()
	else:
		if get_parent().get_parent()._clas == get_parent().get_parent()._clases.hunter:
			isHunter()
		elif get_parent().get_parent()._clas == get_parent().get_parent()._clases.mage:
			isMage()
		elif get_parent().get_parent()._clas == get_parent().get_parent()._clases.warrior:
			isWarrior()
		elif get_parent().get_parent()._clas == get_parent().get_parent()._clases.guardian:
			isGuardian()
		elif get_parent().get_parent()._clas == get_parent().get_parent()._clases.shaman:
			isShaman()
		else: 
			queue_free()
			
func isHunter():
	set_normal_texture(load("res://assets/hunterIcon.png"))
	title = "Hunter"
	desc = " When you have [ 2 , 4 , 6] hunters, your units have [ 25% , 50% , 75% ] bonus attack while attacking"
func isMage():
	set_normal_texture(load("res://assets/MageIcon.png"))
	title = "Mage"
	desc = "When you have [ 3 , 6 ] mages, your Attack abilities trigger [ 1 , 2 ] additional time/s"
	desc2 = "mage"
func isWarrior():
	set_normal_texture(load("res://assets/warriorIcon.png"))
	title = "Warrior"
	desc = "When you have [ 3 , 6 ] warriors, your units attack [ 1 , 2 ] additional time/s"
func isGuardian():
	set_normal_texture(load("res://assets/guardianIcon.png"))
	title = "Guardian"
	desc = "When you have [ 2 , 4 , 6] guardians, your units take [ 1 , 2 , 3 ] reduced damage from all sources"
func isShaman():
	set_normal_texture(load("res://assets/shamanIcon.png"))
	title = "Shaman"
	desc = "When you have [ 3 , 6 ] shamans, your BattleStart abilities trigger [ 1 , 2 ] additional times"
	

	
	
	
	
	
	
	
	

