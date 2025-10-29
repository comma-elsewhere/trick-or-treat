extends PanelContainer

@export var upgrades: VBoxContainer
@export var other_stuff: VBoxContainer
@export var sell_fish: VBoxContainer
@export var talk: VBoxContainer
@export var question: VBoxContainer

@export var upgrades_button: Button
@export var buy_stuff_button: Button
@export var sell_button: Button
@export var talk_button: Button
@export var question_button: Button

var current_panel

func _ready() -> void:
	current_panel = upgrades
	_show_panel(upgrades)
	
	upgrades_button.pressed.connect(navigate_to.bind(upgrades))
	buy_stuff_button.pressed.connect(navigate_to.bind(other_stuff))
	sell_button.pressed.connect(navigate_to.bind(sell_fish))
	talk_button.pressed.connect(navigate_to.bind(talk))
	question_button.pressed.connect(navigate_to.bind(question))

func _show_panel(panel: Control):
	panel.visible = true
	
func navigate_to(panel: Control):
	Global.play_audio(self, "WetClick2", 0.74)
	if current_panel:
		current_panel.visible = false
	
	current_panel = panel
	_show_panel(current_panel)
