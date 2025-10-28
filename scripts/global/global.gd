extends Node

var health: int = 20
var currency: int = 0

#additionary arrays to be appended to lake_stock
var lake_loot: Array[Dictionary] = []
var lake_strange: Array[Dictionary] = []
var lake_special: Array[Dictionary] = []

var equipment: Dictionary = {
	"Rod" = null,
	"Hook" = null,
	"Charm" = null
}

#various stocked inventories
var lake_stock: Array[Dictionary] = []
var inventory_stock: Array[Dictionary] = []
var upgrade_stock: Array[Dictionary] = []
var mystery_stock: Array[Dictionary] = []

func _ready() -> void:
	equipment["Rod"] = GConst.items["BasicRod"]
	equipment["Hook"] = GConst.items["HookOne"]
	
	upgrade_stock.append(GConst.items["Bait"])
	upgrade_stock.append(GConst.items["HookTwo"])
	upgrade_stock.append(GConst.items["AdvancedRod"])
	
	mystery_stock.append(GConst.items["GoodCharm"])
	mystery_stock.append(GConst.items["BadCharm"])
	mystery_stock.append(GConst.items["SoulCharm"])
	
	lake_stock.append(GConst.items["Whitefish"])
	lake_stock.append(GConst.items["Lamprey"])
	lake_stock.append(GConst.items["Trout"])
	lake_stock.append(GConst.items["Sturgeon"])
	lake_stock.append(GConst.items["Salmon"])
	lake_stock.append(GConst.items["Pike"])
	lake_stock.append(GConst.items["Walleye"])
	lake_stock.append(GConst.items["Muskie"])
	lake_stock.append(GConst.items["Bass"])

	lake_loot.append(GConst.items["Ring"])
	lake_loot.append(GConst.items["Skull"])
	lake_loot.append(GConst.items["Dagger"])
	lake_loot.append(GConst.items["Locket"])
	lake_loot.append(GConst.items["Shoe"])
	lake_loot.append(GConst.items["SkullPartOne"])
	lake_loot.append(GConst.items["SkullPartTwo"])
	
	lake_special.append(GConst.items["Laura"])
	
	lake_strange.append(GConst.items["SF1"])
	lake_strange.append(GConst.items["SF2"])
	lake_strange.append(GConst.items["SF3"])
	lake_strange.append(GConst.items["SF4"])
	lake_strange.append(GConst.items["SF5"])
	lake_strange.append(GConst.items["SF6"])
	lake_strange.append(GConst.items["SF7"])
	lake_strange.append(GConst.items["SF8"])
	lake_strange.append(GConst.items["SF9"])
	lake_strange.append(GConst.items["SF10"])
	lake_strange.append(GConst.items["SF11"])
	lake_strange.append(GConst.items["SF12"])
	lake_strange.append(GConst.items["SF13"])
	lake_strange.append(GConst.items["SF14"])
	lake_strange.append(GConst.items["SF15"])
	lake_strange.append(GConst.items["SF16"])
	lake_strange.append(GConst.items["SF17"])
	lake_strange.append(GConst.items["SF18"])
