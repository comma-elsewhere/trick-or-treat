extends VBoxContainer

@export var inv_grid: GridContainer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_visible()

func toggle_visible():
	inv_grid.refill_inventory()
	visible = !visible
	if visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
