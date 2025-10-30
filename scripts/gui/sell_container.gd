extends VBoxContainer

@onready var grid_container: GridContainer = $GridContainer

var sell_item = preload("res://scenes/gui/sell_item.tscn")

func _ready() -> void:
	_stock_inventory()

func restock():
	var children = grid_container.get_children()
	for child in children:
		child.call_deferred("queue_free")
	_stock_inventory()

func _stock_inventory():
	for item in Global.inventory_stock:
		var new_item = sell_item.instantiate()
		new_item.prepare_item(item)
		grid_container.add_child(new_item)
