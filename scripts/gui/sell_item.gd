extends VBoxContainer

const LOOT: int = 1
const STRANGE_FISH: int = 3
const SPECIAL_FISH: int = 10

@export var texture_rect: TextureRect

var item: Dictionary

func prepare_item(item_dict: Dictionary):
	item = item_dict
	texture_rect.texture = load(item_dict.icon)

func _on_button_button_up() -> void:
	Global.play_audio(self, "WetClick2", 0.74)
	_exchange_goods(item)
	_lore_counter()
	call_deferred("queue_free")
	
func _exchange_goods(sell_item: Dictionary):
	Global.currency += sell_item.value
	var stock_index = Global.inventory_stock.find(sell_item)
	Global.inventory_stock.pop_at(stock_index)
	Global.upgrade_stock.append(sell_item)
	
func _lore_counter():
	if item.type == "loot":
		Global.lore_counter += LOOT
	elif item.type == "strange":
		Global.lore_counter += STRANGE_FISH
	elif item.type == "special":
		Global.lore_counter += SPECIAL_FISH
