extends TextureRect

@export_enum("Rod", "Hook", "Charm") var type: String

var current_rod_id = ""

func _process(_delta: float) -> void:
	if type == "Rod" and Global.current_rod_id != current_rod_id:
		update_equipment()

func update_equipment():
	current_rod_id = Global.current_rod_id
	
	if type == "Rod":
		texture = Global.get_rod_icon(current_rod_id)
		var rod = Global.get_current_rod()
		if rod:
			tooltip_text = "Rod\nAccel: " + str(rod.bar_accel)
