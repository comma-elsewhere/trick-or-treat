extends Label

@export_enum("Money", "Lore", "Health") var type: String

func _process(_delta: float) -> void:
	if type == "Money":
		text = str(Global.currency)
	elif type == "Lore":
		text = str(Global.lore_counter)
	elif type == "Health":
		text = str(Global.health)
