extends Control

@export var main_menu: VBoxContainer
@export var main_settings: VBoxContainer
@export var video_settings: VBoxContainer
@export var audio_settings: VBoxContainer
@export var control_map: VBoxContainer

@export var settings_button: Button
@export var video_button: Button
@export var audio_button: Button
@export var controls_button: Button
@export var return_button: Button

var current_panel 

func _ready() -> void:
	current_panel = main_menu
	_show_panel(main_menu)
	
	settings_button.button_up.connect(navigate_to.bind(main_settings))
	video_button.button_up.connect(navigate_to.bind(video_settings))
	audio_button.button_up.connect(navigate_to.bind(audio_settings))
	controls_button.button_up.connect(navigate_to.bind(control_map))
	return_button.button_up.connect(navigate_to.bind(main_menu))

func _show_panel(panel: Control):
	panel.visible = true
	
func navigate_to(panel: Control):
	if current_panel:
		current_panel.visible = false
	
	current_panel = panel
	_show_panel(current_panel)

func _on_back_button_button_up() -> void:
	navigate_to(main_settings)

func _on_quit_button_up() -> void:
	get_tree().quit()

func _on_new_game_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")
