extends HFlowContainer

var weapons: Array[String] = []
var weapons_lvl: Array[int] = []
var weaponSlotScene = preload("res://scenes/WeaponSlot.tscn")
var slots:= []

var IconDict:={
	"Axe":load("res://textures/weapons/axe projectile.png"),
	"Cannon":load("res://textures/weapons/cannonball.png"),
	"Dragonator":load("res://textures/weapons/dragonator.png")
}
var weaponDict:={
	"Dragonator":{
		"upgrades": [
			{
				"damage":10
			},
			{
				"damage":15
			},
			{
				"damage":20
			},
			{
				"damage":25
			},
			{
				"damage":30
			}
		]
	},
	"Cannon": {
		"upgrades": [
			{
				"fire_rate":.66,
				"proj_num":1,
				"proj_speed":1,
				"damage":10
			},
			{
				"fire_rate":1.0,
				"proj_num":1,
				"proj_speed":1,
				"damage":15
			},
			{
				"fire_rate":1,
				"proj_num":2,
				"proj_speed":1,
				"damage":15
			},
			{
				"fire_rate":1,
				"proj_num":2,
				"proj_speed":1,
				"damage":20
			},
			{
				"fire_rate":1.25,
				"proj_num":2,
				"proj_speed":1,
				"damage":20
			}
		]
	},
	"Axe":{
		"upgrades": [
			{
				"fire_rate":1.0,
				"proj_num":1,
				"proj_speed":1,
				"damage":10
			},
			{
				"fire_rate":1.0,
				"proj_num":1,
				"proj_speed":1,
				"damage":15
			},
			{
				"fire_rate":1,
				"proj_num":2,
				"proj_speed":1,
				"damage":15
			},
			{
				"fire_rate":1,
				"proj_num":2,
				"proj_speed":1,
				"damage":20
			},
			{
				"fire_rate":1.25,
				"proj_num":2,
				"proj_speed":1,
				"damage":20
			}
		]
	}
}

@onready var playerObj = get_tree().root.get_child(0).get_node("Main2D/Player")

func reloadContainer():
	print(playerObj.get_node("%Raft/Dragonator"))
	playerObj.get_node("%Raft/Dragonator").visible=false
	playerObj.get_node("%Raft/Dragonator").damage = 0
	for n in range(0,8):
		if weapons.size() > n:
			slots[n].changeWep(IconDict[weapons[n]],weapons_lvl[n])
			if(weapons[n] == "Dragonator"):
				playerObj.get_node("%Raft/Dragonator").visible=true
				playerObj.get_node("%Raft/Dragonator").damage = weaponDict["Dragonator"]["upgrades"][weapons_lvl[n]]["damage"]
		else:
			slots[n].changeWep(null,0)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(0,8):
		var newSlot = weaponSlotScene.instantiate()
		add_child(newSlot)
		slots.append(newSlot)
	#addWeapon("Axe")
	addWeapon("Cannon")
	reloadContainer()
	

func addWeapon(wep_name):
	weapons.append(wep_name)
	weapons_lvl.append(1)
	reloadContainer()
	
