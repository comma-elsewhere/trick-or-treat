extends TextureRect

func set_item(icon_path:String, item_name:String, desc:String):
	texture = load(icon_path)
	tooltip_text = item_name + "\n" + desc
