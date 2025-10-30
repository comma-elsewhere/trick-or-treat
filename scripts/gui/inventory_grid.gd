extends GridContainer

@onready var inv_item = preload("res://scenes/gui/inv_item.tscn")

@onready var children = get_children()

var inventory_count: int

func _ready() -> void:
	if !Global.inventory_stock.is_empty():
		inventory_count = Global.inventory_stock.size()
		fill_inventory()

func refill_inventory():
	for child in children:
		var child_count = child.get_child_count()
		if child_count != 0:
			var old_inv = child.get_child(0)
			child.remove_child(old_inv)
	fill_inventory()

#func _process(_delta: float) -> void:
#	while Global.inventory_stock.size() > inventory_count:
#		var diff = Global.inventory_stock.size() - inventory_count
#		if diff == 1:
#			var new_item = inv_item.instantiate()
#			new_item.set_item(Global.inventory_stock.back().icon, Global.inventory_stock.back().name, Global.inventory_stock.back().description)
#			children[inventory_count].add_child(new_item)
			
			
func fill_inventory():
	for i in range(Global.inventory_stock.size()):
		var new_item = inv_item.instantiate()
		new_item.set_item(Global.inventory_stock[i].icon, Global.inventory_stock[i].name, Global.inventory_stock[i].description)
		children[i].add_child(new_item)
