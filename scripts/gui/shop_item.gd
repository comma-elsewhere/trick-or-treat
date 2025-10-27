extends VBoxContainer

@export var button: Button
@export var name_label: Label 
@export var price_label: Label 


var item: String
var price: int

func prepare_item(item_name: String, item_price: int, icon_path: String):
	item = item_name
	price = item_price
	name_label.text = item_name
	price_label.text = "$" + str(item_price)
	button.icon = load(icon_path)

func _on_button_button_up() -> void:
	pass # Replace with function body.
