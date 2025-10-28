extends VBoxContainer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		
	if visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		
	if Global.inventory_stock.size() > 24:
		Global.inventory_stock.resize(24)
