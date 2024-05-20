extends HFlowContainer

var weapons: Array[String] = []
var weapons_lvl: Array[int] = []
var weaponSlotScene = preload("res://scenes/WeaponSlot.tscn")
var slots:= []

var ProjDict:={
	"Axe":load("res://textures/weapons/axe projectile.png")
}
var IconDict:={
	"Axe":load("res://textures/weapons/arxe_icon.png"),
	"Cannon":load("res://textures/weapons/connonball_icon.png"),
	"Dragonator":load("res://textures/weapons/dargonator_icon.png")
}
var weaponDict:={
	"Dragonator":{
		"upgrades": [
			{
				"damage":10
			},
			{
				"damage":15,
				"text":"10 -> 15 damage"
			},
			{
				"damage":20,
				"text":"15 -> 20 damage"
			},
			{
				"damage":25,
				"text":"20 -> 25 damage"
			},
			{
				"damage":30,
				"text":"25 -> 30 damage"
			}
		]
	},
	"Cannon": {
		"upgrades": [
			{
				"fire_rate":.333,
				"proj_num":1,
				"proj_speed":1,
				"damage":4
			},
			{
				"fire_rate":.333,
				"proj_num":1,
				"proj_speed":1,
				"damage":7,
				"text":"4 -> 7 damage"
			},
			{
				"fire_rate":.2,
				"proj_num":1,
				"proj_speed":1,
				"damage":7,
				"text":"33% faster fire rate"
			},
			{
				"fire_rate":.2,
				"proj_num":1,
				"proj_speed":1,
				"damage":10,
				"text":"7 -> 10 damage"
			},
			{
				"fire_rate":.2,
				"proj_num":1,
				"proj_speed":1,
				"damage":14,
				"text":"10 -> 14 damage"
			}
		]
	},
	"Axe":{
		"upgrades": [
			{
				"fire_rate":1.0,
				"proj_num":1,
				"proj_speed":1,
				"damage":15
			},
			{
				"fire_rate":1.0,
				"proj_num":1,
				"proj_speed":1,
				"damage":20,
				"text":"15 -> 20 damage"
			},
			{
				"fire_rate":1.0,
				"proj_num":2,
				"proj_speed":1,
				"damage":20,
				"text":"1 -> 2 projectiles"
			},
			{
				"fire_rate":.8,
				"proj_num":2,
				"proj_speed":1,
				"damage":20,
				"text":"20% faster fire rate"
			},
			{
				"fire_rate":.8,
				"proj_num":2,
				"proj_speed":1,
				"damage":30,
				"text":"20 -> 30 damage"
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
			if(weapons[n] == "Cannon"):
				$"../../../Cannon".damage = weaponDict["Cannon"]["upgrades"][weapons_lvl[n-1]]["damage"]
				$"../../../Cannon".set_firerate(weaponDict["Cannon"]["upgrades"][weapons_lvl[n-1]]["fire_rate"])
			elif(weapons[n] == "Dragonator"):
				playerObj.get_node("%Raft/Dragonator").visible=true
				playerObj.get_node("%Raft/Dragonator").damage = weaponDict["Dragonator"]["upgrades"][weapons_lvl[n-1]]["damage"]
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
	
