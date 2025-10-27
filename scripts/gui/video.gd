extends VBoxContainer

@export var resolution: OptionButton
@export var fullscreen: CheckBox
@export var borderless: CheckBox

func _ready() -> void:
	resolution.item_selected.connect(_on_resolution_selected)
	fullscreen.toggled.connect(_on_fullscreen_toggled)
	borderless.toggled.connect(_on_borderless_toggled)
	
	var resolution_options: Array[Vector2i] = [
		Vector2i(1920,1080),
		Vector2i(1600,900),
		Vector2i(1280,720),
		Vector2i(640, 360),
		Vector2i(320, 180)
	]
	
	for res in resolution_options:
		resolution.add_item("%dx%d" % [res.x, res.y])
		
	load_current_settings()
		
func load_current_settings():
	var mode = DisplayServer.window_get_mode()
	fullscreen.button_pressed = mode == DisplayServer.WINDOW_MODE_FULLSCREEN
	borderless.button_pressed = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	
	var window_size = DisplayServer.window_get_size()
	for i in range(resolution.item_count):
		var res_text = resolution.get_item_text(i)
		var parts = res_text.split("x")
		if parts.size() == 2 and int(parts[0]) == window_size.x and int(parts[1]) == window_size.y:
			resolution.select(i)
			break

func _on_resolution_selected(index: int):
	var text = resolution.get_item_text(index)
	var parts = text.split("x")
	if parts.size() == 2:
		DisplayServer.window_set_size(Vector2i(int(parts[0]), int(parts[1])))

func _on_fullscreen_toggled(enabled: bool):
	if enabled:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(enabled: bool):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, enabled)
