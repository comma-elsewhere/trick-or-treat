extends TextureRect

@export_enum("Rod", "Hook", "Charm") var type: String

func _process(_delta: float) -> void:
	if Global.equipment[type] != null:
		texture = load(Global.equipment[type].icon)
		tooltip_text = Global.equipment[type].name  + "\n" + Global.equipment[type].description
