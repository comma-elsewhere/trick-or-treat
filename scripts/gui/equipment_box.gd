extends HBoxContainer

@onready var children = get_children()

func _ready() -> void:
	for child in children:
		if Global.equipment[child.name] != null:
			child.texture = load(Global.equipment[child.name].icon)
			child.tooltip_text = Global.equipment[child.name].name + "\n" + Global.equipment[child.name].description
