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
			Global.inventory_stock.append(hold_item)
		else:
			stock_index = Global.upgrade_stock.find(item)
			var hold_item = Global.upgrade_stock.pop_at(stock_index)
			Global.inventory_stock.append(hold_item)
		call_deferred("queue_free")
