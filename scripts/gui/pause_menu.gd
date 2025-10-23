extends PanelContainer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		toggle_visible()
		
func toggle_visible():
	visible = !visible
	get_tree().paused = visible
	if visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _on_exit_game_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")


func _on_continue_button_up() -> void:
	toggle_visible()
