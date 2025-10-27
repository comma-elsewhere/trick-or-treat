extends GridContainer

@onready var inv_item = preload("res://scenes/gui/inv_item.tscn")

@onready var children = get_children()

func _ready() -> void:
	if !Global.inventory_stock.is_empty():
		for i in range(Global.inventory_stock.size()):
			var new_item = inv_item.instantiate()
			new_item.set_item(Global.inventory_stock[i].icon, Global.inventory_stock[i].name, Global.inventory_stock[i].description)
			children[i].add_child(new_item)
