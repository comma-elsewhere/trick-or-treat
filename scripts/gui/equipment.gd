extends TextureRect

@export_enum("Rod", "Hook", "Charm") var type: String

var current_rod_id = ""

func _process(_delta: float) -> void:
	#if type == "Rod" and Global.current_rod_id != current_rod_id:
	if Global.equipment_dict[type] != null:
		update_equipment(Global.equipment_dict[type])

func update_equipment(item: Dictionary):
	texture = load(item.icon)
	tooltip_text = item.name + "\n" + item.description
	if type == "Rod":
		match item.name:
			"Basic Rod":
				Global.current_rod_id = "basic"
			"Advanced Rod":
				Global.current_rod_id = "advanced"
			"Cursed Rod":
				Global.current_rod_id = "cursed"
		
