extends VBoxContainer

@export_enum("Upgrades", "Mystery") var stock_type: String

@onready var grid_container: GridContainer = $GridContainer

var shop_item = preload("res://scenes/gui/shop_item.tscn")

func _ready() -> void:
	if stock_type == "Upgrades":
		for item in Global.upgrade_stock:
			var new_item = shop_item.instantiate()
			new_item.prepare_item(item.name, item.value, item.icon)
			grid_container.add_child(new_item)
	else:
		for item in Global.mystery_stock:
			var new_item = shop_item.instantiate()
			new_item.prepare_item(item.name, item.value, item.icon)
			grid_container.add_child(new_item)
		
