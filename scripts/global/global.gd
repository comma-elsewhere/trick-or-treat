extends Node

var health: int = 20
var currency: int = 20
var lore_counter: int = 0

#additionary arrays to be appended to lake_stock
var lake_loot: Array[Dictionary] = []
var lake_strange: Array[Dictionary] = []
var lake_special: Array[Dictionary] = []


signal equipment_changed(slot: String)

var rods: Dictionary = {
	"basic": preload("res://resources/item_pool/basic_pole.tres"),
	"advanced": preload("res://resources/item_pool/advancedrod.tres"),
	"cursed": preload("res://resources/item_pool/cursedrod.tres")
}

var current_rod_id: String = "advanced" 

var equipment = {
	"Rod": preload("res://resources/item_pool/cursedrod.tres"),
	"Hook": null,
	"Charm": null
}

func equip_item(slot: String, item):
	equipment[slot] = item
	equipment_changed.emit(slot)
	
var rod_icons = {
	"basic": preload("res://assets/visual/final_icons/Beginner_Rod.png"),
	"advanced": preload("res://assets/visual/final_icons/Advanced_Rod.png"),
	"cursed": preload("res://assets/visual/final_icons/Cursed_Rod.png")
}

func get_rod_icon(rod_id: String) -> Texture2D:
	return rod_icons.get(rod_id)



func get_current_rod() -> RodType:
	if current_rod_id in rods:
		return rods[current_rod_id]
	
	push_warning("Rod '%s' not found, using basic" % current_rod_id)
	return rods["basic"]

func equip_rod(rod_id: String):
	if rod_id in rods:
		current_rod_id = rod_id
		equipment["Rod"] = rods[rod_id]  # ← Actualizar equipment también
		print("Equipped rod: ", rod_id)
	else:
		push_error("Rod '%s' doesn't exist!" % rod_id)
		
#various stocked inventories
var lake_stock: Array[Dictionary] = []
var inventory_stock: Array[Dictionary] = []
var upgrade_stock: Array[Dictionary] = []
var mystery_stock: Array[Dictionary] = []
var equipment_dict: Dictionary = {
	"Rod" = null,
	"Hook" = null,
	"Charm" = null,
}

func _ready() -> void:
	equipment_dict["Rod"] = GConst.items["BasicRod"]
	equipment_dict["Hook"] = GConst.items["HookOne"]
	
	upgrade_stock.append(GConst.items["Bait"])
	upgrade_stock.append(GConst.items["HookTwo"])
	upgrade_stock.append(GConst.items["AdvancedRod"])
	
	mystery_stock.append(GConst.items["Chum"])
	mystery_stock.append(GConst.items["Charm"])
	mystery_stock.append(GConst.items["HookThree"])
	mystery_stock.append(GConst.items["CursedRod"])
	
	lake_stock.append(GConst.items["Whitefish"])
	lake_stock.append(GConst.items["Trout"])
	lake_stock.append(GConst.items["Sturgeon"])
	lake_stock.append(GConst.items["Walleye"])
	lake_stock.append(GConst.items["Bass"])
	lake_stock.append(GConst.items["Whitefish"])
	lake_stock.append(GConst.items["Trout"])
	lake_stock.append(GConst.items["Sturgeon"])
	lake_stock.append(GConst.items["Walleye"])
	lake_stock.append(GConst.items["Bass"])

	lake_loot.append(GConst.items["Shoe"])
	lake_loot.append(GConst.items["Skull"])
	lake_loot.append(GConst.items["SquidSkull"])
	lake_loot.append(GConst.items["Locket"])
	lake_loot.append(GConst.items["HairClip"])
	lake_loot.append(GConst.items["Raincoat"])
	lake_loot.append(GConst.items["Hat"])
	
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

func play_audio(sound_parent: Node, audio_file: String, offset: float):
	var new_sound = AudioStreamPlayer.new()
	var audio_file_path: String = "res://assets/audio/sound effects/" + audio_file + ".mp3"
	new_sound.stream = load(audio_file_path)
	new_sound.finished.connect(new_sound.queue_free)
	sound_parent.add_child(new_sound)
	new_sound.play(offset)
