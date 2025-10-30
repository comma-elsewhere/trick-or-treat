extends VBoxContainer

@export var button: Button
@export var name_label: Label 
@export var price_label: Label 


var item: Dictionary
var price: int
var type: String
var mystery: bool

func prepare_item(item_dict: Dictionary, is_mystery: bool):
	item = item_dict
	price = item_dict.value
	type = item_dict.type
	mystery = is_mystery
	name_label.text = item_dict.name
	price_label.text = "$" + str(price)
	button.icon = load(item_dict.icon)

func _on_button_button_up() -> void:
	Global.play_audio(self, "WetClick2", 0.74)
	if price <= Global.currency and Global.inventory_stock.size() < 24:
		Global.currency -= price
		var stock_index: int
		if mystery:
			stock_index = Global.mystery_stock.find(item)
			var hold_item = Global.mystery_stock.pop_at(stock_index)
			_edit_equipment(hold_item)
		else:
			stock_index = Global.upgrade_stock.find(item)
			var hold_item = Global.upgrade_stock.pop_at(stock_index)
			_edit_equipment(hold_item)
			
		call_deferred("queue_free")

func _edit_equipment(new_item: Dictionary):
	match new_item.type:
		"rod":
			var key = GConst.items.find_key(Global.equipment_dict["Rod"])
			Global.inventory_stock.append(GConst.items[key])
			Global.equipment_dict["Rod"] = new_item
		"hook":
			var key = GConst.items.find_key(Global.equipment_dict["Hook"])
			Global.inventory_stock.append(GConst.items[key])
			Global.equipment_dict["Hook"] = new_item
		"charm":
			if Global.equipment_dict["Charm"] != null:
				var key = GConst.items.find_key(Global.equipment_dict["Charm"])
				Global.inventory_stock.append(GConst.items[key])
			Global.equipment_dict["Charm"] = new_item
			
	if new_item.name == "Advanced Rod" or new_item.name == "Normal Hook":
		if !Global.lake_loot.is_empty():
			Global.lake_stock.append_array(Global.lake_loot)
			Global.lake_loot.clear()
	elif new_item.name == "Cursed Rod" or new_item.name == "Pro Hook" or new_item.name == "Chum":
		if !Global.lake_strange.is_empty():
			Global.lake_stock.append_array(Global.lake_strange)
			Global.lake_strange.clear()
	elif new_item.name == "Charm":
		if !Global.lake_special.is_empty():
			Global.lake_stock.append_array(Global.lake_special)
			Global.lake_special.clear()
