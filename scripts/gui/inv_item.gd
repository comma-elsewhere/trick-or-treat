extends TextureRect

@export var label: Label

func set_item(icon_path:String, item_name:String, desc:String):
	texture = load(icon_path)
	label.text = item_name
	tooltip_text = desc
