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
		if name == "Earth":
			isEarth()
		if name == "Wind":
			isWind()
		if name == "Water":
			isWater()
		if name == "Fire":
			isFire()
	else:
		if get_parent().get_parent()._tribe == get_parent().get_parent()._tribes.water:
			isWater()
		elif get_parent().get_parent()._tribe == get_parent().get_parent()._tribes.fire:
			isFire()
		elif get_parent().get_parent()._tribe == get_parent().get_parent()._tribes.wind:
			isWind()
		elif get_parent().get_parent()._tribe == get_parent().get_parent()._tribes.earth:
			isEarth()
		else:
			queue_free()
func isEarth():
	set_normal_texture(load("res://assets/earthIcon.png"))
	desc = "If you have [ 3 , 6 ] earth units, all allies gain [ 25% , 50% ] health when the battle starts"
	title = "Earth"
func isWind():
	set_normal_texture(load("res://assets/windIcon.png"))
	desc = "If you have [2 , 4 , 6] wind units, all allies gain [ +1/+1, +2/+2, +3/+3 ] when the battle starts"
	title = "Wind"
func isWater():
	set_normal_texture(load("res://assets/waterIcon.png"))
	title = "Water"
	desc = "If you have [ 3, 6 ] water units, "
func isFire():
	set_normal_texture(load("res://assets/fireIcon.png"))
	title = "Fire"
	desc = "If you have [ 2, 4, 6 ] fire units, enemies take [ 1, 2, 3] extra damage from all sources"
	


