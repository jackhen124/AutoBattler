extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var unitInfo = get_node("UnitInfo")

# Called when the node enters the scene tree for the first time.
func _ready():
	unitInfo.hide()
	get_node("BonusInfo").hide()
	get_node("BonusInfo2").hide()
	#get_node("BonusInfo").hide()
	pass # Replace with function body.

func displayUnitInfo(unit):
	unitInfo.get_node("Sprite").set_sprite_frames(unit.get_node("Sprite").get_sprite_frames())
	unitInfo.get_node("Sprite").set_speed_scale(unit.get_node("Sprite").get_speed_scale())
	unitInfo.get_node("Health").text = str(unit._hp)
	unitInfo.get_node("Attack").text = str(unit._attack)
	unitInfo.get_node("Desc").text = unit._desc
	unitInfo.get_node("TribeSprite").set_texture(unit.get_node("UnitOverlay").get_node("TribeIcon").get_normal_texture())
	unitInfo.get_node("ClasSprite").set_texture(unit.get_node("UnitOverlay").get_node("ClasIcon").get_normal_texture())
	unitInfo.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
