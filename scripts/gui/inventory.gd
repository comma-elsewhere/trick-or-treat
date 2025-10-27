extends PanelContainer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		
	if Global.inventory_stock.size() > 24:
		Global.inventory_stock.resize(24)
