extends VBoxContainer

@onready var grid_container: GridContainer = $GridContainer

var sell_item = preload("res://scenes/gui/sell_item.tscn")

func _ready() -> void:
	for item in Global.inventory_stock:
		var new_item = sell_item.instantiate()
		new_item.prepare_item(item.icon, item.name, item.value)
		grid_container.add_child(new_item)
