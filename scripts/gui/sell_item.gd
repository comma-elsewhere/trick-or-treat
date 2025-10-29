extends VBoxContainer

@onready var texture_rect: TextureRect = $PanelContainer/TextureRect

var item: String
var price: int

func prepare_item(icon_path:String, item_name: String, item_price: int):
	item = item_name
	price = item_price
	texture_rect.texture = load(icon_path)

func _on_button_button_up() -> void:
	Global.play_audio(self, "WetClick2", 0.74)
	pass # Replace with function body.
